// ~/.config/nvim/config.ts
import { BaseConfig, ContextBuilder, Dpp, Plugin } from "https://deno.land/x/dpp_vim@v1.0.0/types.ts";
import { Denops, fn } from "https://deno.land/x/dpp_vim@v1.0.0/deps.ts";

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }): Promise<{ plugins: Plugin[]; stateLines: string[] }> {
    args.contextBuilder.setGlobal({ protocols: ["git"] });

    const defaultToml = await fn.expand(args.denops, "$HOME/.config/nvim/toml/dein.toml");
    const tomlPath = Deno.env.get("NVIM_DPP_TOML") ?? defaultToml;

    const [context, options] = await args.contextBuilder.get(args.denops);

    const toml = await args.dpp.extAction(args.denops, context, options, "toml", "load", {
      path: tomlPath,
      options: {},
    });

    const plugins: Plugin[] = toml?.plugins ?? [];

    const lazyResult = await args.dpp.extAction(args.denops, context, options, "lazy", "makeState", {
      plugins,
    });

    return {
      plugins: lazyResult?.plugins ?? plugins,
      stateLines: lazyResult?.stateLines ?? [],
    };
  }
}

