import { BaseConfig, ContextBuilder, Dpp, Plugin } from "https://deno.land/x/dpp_vim@v1.0.0/types.ts";
import { Denops, fn } from "https://deno.land/x/dpp_vim@v1.0.0/deps.ts";
import { expandGlob } from "https://deno.land/std/fs/mod.ts";

type LazyMakeStateResult = { plugins: Plugin[]; stateLines: string[] };

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }): Promise<{ plugins: Plugin[]; stateLines: string[] }> {
    args.contextBuilder.setGlobal({ protocols: ["git"] });

    const isWindows = Deno.build.os === "windows";
    const tomlDir = await fn.expand(args.denops, isWindows ? "$LOCALAPPDATA/nvim/toml" : "$HOME/.config/nvim/toml");
    const workDir = await fn.expand(args.denops, isWindows ? "$LOCALAPPDATA/nvim/work" : "$HOME/.config/nvim/work");
    try {
      await Deno.mkdir(tomlDir, { recursive: true });
    } catch (_) {}
    try {
      await Deno.mkdir(workDir, { recursive: true });
    } catch (_) {}

    const [context, options] = await args.contextBuilder.get(args.denops);
    const tomls: Plugin[] = [];

    // 🔍 tomlDir にある .toml ファイルをすべて読み込む
    for await (const file of expandGlob(`${tomlDir}/*.toml`)) {
      const toml = await args.dpp.extAction(args.denops, context, options, "toml", "load", {
        path: file.path,
        options: {},
      });
      if (toml) {
        tomls.push(...toml.plugins);
      }
    }

    // 🔍 ローカルプラグインのロード
    const localPlugins = await args.dpp.extAction(args.denops, context, options, "local", "local", {
      directory: workDir,
      options: { frozen: true, merged: false },
    });

    // 💤 lazy拡張を使って状態を作成
    const lazyResult = await args.dpp.extAction(args.denops, context, options, "lazy", "makeState", {
      plugins: [...tomls, ...localPlugins],
    });

    console.log("Loaded Plugins:", lazyResult?.plugins ?? []);
    return { plugins: lazyResult?.plugins ?? [], stateLines: lazyResult?.stateLines ?? [] };
  }
}

