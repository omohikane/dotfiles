import { BaseConfig, ContextBuilder, Dpp, Plugin } from "https://deno.land/x/dpp_vim@v1.0.0/types.ts";
import { Denops, fn } from "https://deno.land/x/dpp_vim@v1.0.0/deps.ts";

type LazyMakeStateResult = { plugins: Plugin[]; stateLines: string[] };

export class Config extends BaseConfig {
    override async config(args: { denops: Denops; contextBuilder: ContextBuilder; basePath: string; dpp: Dpp; })
    : Promise<{ plugins: Plugin[]; stateLines: string[] }> {
        args.contextBuilder.setGlobal({ protocols: ["git"] });

        // 🔹 Windows / Linux に対応する `toml` のディレクトリを設定
        const isWindows = Deno.build.os === "windows";
        const tomlDir = await fn.expand(args.denops, isWindows ? "$LOCALAPPDATA/nvim/toml" : "$HOME/.config/nvim/toml");
        const workDir = await fn.expand(args.denops, isWindows ? "$LOCALAPPDATA/nvim/work" : "$HOME/.config/nvim/work");

        // 🔹 dpp のコンテキストを取得
        const [context, options] = await args.contextBuilder.get(args.denops);

        // 🔹 TOML ファイルをロード
        const tomls: Plugin[] = [];
        for (const tomlFile of ["dein.toml", "dein_lazy.toml"]) {
            const toml = await args.dpp.extAction(args.denops, context, options, "toml", "load", {
                path: `${tomlDir}/${tomlFile}`,
                options: { lazy: tomlFile.includes("lazy") },
            });
            if (toml) {
                tomls.push(...toml.plugins);
            }
        }

        // 🔹 ローカルプラグインをロード
        const localPlugins = await args.dpp.extAction(args.denops, context, options, "local", "local", {
            directory: workDir,
            options: { frozen: true, merged: false },
        });

        // 🔹 Lazy ロードを適用
        const lazyResult = await args.dpp.extAction(args.denops, context, options, "lazy", "makeState", {
            plugins: [...tomls, ...localPlugins],
        });

        // 🔹 デバッグ: プラグイン一覧を表示
        console.log("Loaded Plugins:", lazyResult?.plugins ?? []);

        return { plugins: lazyResult?.plugins ?? [], stateLines: lazyResult?.stateLines ?? [] };
    }
}

