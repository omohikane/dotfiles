// ~/.config/nvim/config.ts (最終修正版)

import { BaseConfig, ContextBuilder, Dpp, Plugin } from "https://deno.land/x/dpp_vim@v1.0.0/types.ts";
import { Denops, fn } from "https://deno.land/x/dpp_vim@v1.0.0/deps.ts";

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }): Promise<{ plugins: Plugin[]; stateLines: string[] }> {
    // 修正1: オリジナルに戻す (拡張機能の指定は不要)
    args.contextBuilder.setGlobal({ protocols: ["git"] });

    // 修正2: $HOME/.config/nvim/toml/dein.toml を参照するように修正
    const defaultToml = await fn.expand(args.denops, "$HOME/.config/nvim/toml/dein.toml");
    
    // エラーメッセージで出ていた '/home/ripple/.config/nvim/dein.toml' というパス参照を回避する
    const tomlPath = Deno.env.get("NVIM_DPP_TOML") ?? defaultToml;

    const [context, options] = await args.contextBuilder.get(args.denops);

    // toml拡張機能を使用する (ここで'toml'が有効化される)
    const toml = await args.dpp.extAction(args.denops, context, options, "toml", "load", {
      path: tomlPath,
      options: {},
    });

    const plugins: Plugin[] = toml?.plugins ?? [];

    // lazy拡張機能を使用する (ここで'lazy'が有効化される)
    const lazyResult = await args.dpp.extAction(args.denops, context, options, "lazy", "makeState", {
      plugins,
    });

    return {
      plugins: lazyResult?.plugins ?? plugins,
      stateLines: lazyResult?.stateLines ?? [],
    };
  }
}
