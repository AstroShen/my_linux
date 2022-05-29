#-- START ZCACHE GENERATED FILE
#-- GENERATED: Fri Apr 15 10:03:15 CST 2022
#-- ANTIGEN v2.2.2
_antigen () {
	local -a _1st_arguments
	_1st_arguments=('apply:Load all bundle completions' 'bundle:Install and load the given plugin' 'bundles:Bulk define bundles' 'cleanup:Clean up the clones of repos which are not used by any bundles currently loaded' 'cache-gen:Generate cache' 'init:Load Antigen configuration from file' 'list:List out the currently loaded bundles' 'purge:Remove a cloned bundle from filesystem' 'reset:Clears cache' 'restore:Restore the bundles state as specified in the snapshot' 'revert:Revert the state of all bundles to how they were before the last antigen update' 'selfupdate:Update antigen itself' 'snapshot:Create a snapshot of all the active clones' 'theme:Switch the prompt theme' 'update:Update all bundles' 'use:Load any (supported) zsh pre-packaged framework') 
	_1st_arguments+=('help:Show this message' 'version:Display Antigen version') 
	__bundle () {
		_arguments '--loc[Path to the location <path-to/location>]' '--url[Path to the repository <github-account/repository>]' '--branch[Git branch name]' '--no-local-clone[Do not create a clone]'
	}
	__list () {
		_arguments '--simple[Show only bundle name]' '--short[Show only bundle name and branch]' '--long[Show bundle records]'
	}
	__cleanup () {
		_arguments '--force[Do not ask for confirmation]'
	}
	_arguments '*:: :->command'
	if (( CURRENT == 1 ))
	then
		_describe -t commands "antigen command" _1st_arguments
		return
	fi
	local -a _command_args
	case "$words[1]" in
		(bundle) __bundle ;;
		(use) compadd "$@" "oh-my-zsh" "prezto" ;;
		(cleanup) __cleanup ;;
		(update|purge) compadd $(type -f \-antigen-get-bundles &> /dev/null || antigen &> /dev/null; -antigen-get-bundles --simple 2> /dev/null) ;;
		(theme) compadd $(type -f \-antigen-get-themes &> /dev/null || antigen &> /dev/null; -antigen-get-themes 2> /dev/null) ;;
		(list) __list ;;
	esac
}
antigen () {
  local MATCH MBEGIN MEND
  [[ "$ZSH_EVAL_CONTEXT" =~ "toplevel:*" || "$ZSH_EVAL_CONTEXT" =~ "cmdarg:*" ]] && source "/home/astro/.zsh/antigen.zsh" && eval antigen $@;
  return 0;
}
typeset -gaU fpath path
fpath+=(/home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/git /home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract /home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmux /home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/z /home/astro/.zsh/antigen/bundles/voronkovich/gitignore.plugin.zsh /home/astro/.zsh/antigen/bundles/jeffreytse/zsh-vi-mode /home/astro/.zsh/antigen/bundles/zsh-users/zsh-syntax-highlighting /home/astro/.zsh/antigen/bundles/zsh-users/zsh-autosuggestions /home/astro/.zsh/antigen/bundles/romkatv/powerlevel10k) path+=(/home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/git /home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract /home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmux /home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/z /home/astro/.zsh/antigen/bundles/voronkovich/gitignore.plugin.zsh /home/astro/.zsh/antigen/bundles/jeffreytse/zsh-vi-mode /home/astro/.zsh/antigen/bundles/zsh-users/zsh-syntax-highlighting /home/astro/.zsh/antigen/bundles/zsh-users/zsh-autosuggestions /home/astro/.zsh/antigen/bundles/romkatv/powerlevel10k)
_antigen_compinit () {
  autoload -Uz compinit; compinit -d "/home/astro/.zsh/antigen/.zcompdump"; compdef _antigen antigen
  add-zsh-hook -D precmd _antigen_compinit
}
autoload -Uz add-zsh-hook; add-zsh-hook precmd _antigen_compinit
compdef () {}

if [[ -n "" ]]; then
  ZSH=""; ZSH_CACHE_DIR=""
fi
#--- BUNDLES BEGIN
source '/home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/git/git.plugin.zsh';
source '/home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract/extract.plugin.zsh';
source '/home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmux/tmux.plugin.zsh';
source '/home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/z/z.plugin.zsh';
source '/home/astro/.zsh/antigen/bundles/voronkovich/gitignore.plugin.zsh/gitignore.plugin.zsh';
source '/home/astro/.zsh/antigen/bundles/jeffreytse/zsh-vi-mode/zsh-vi-mode.plugin.zsh';
source '/home/astro/.zsh/antigen/bundles/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh';
source '/home/astro/.zsh/antigen/bundles/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh';
source '/home/astro/.zsh/antigen/bundles/romkatv/powerlevel10k/powerlevel10k.zsh-theme.antigen-compat';

#--- BUNDLES END
typeset -gaU _ANTIGEN_BUNDLE_RECORD; _ANTIGEN_BUNDLE_RECORD=('https://github.com/robbyrussell/oh-my-zsh.git plugins/git plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/extract plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/tmux plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/z plugin true' 'https://github.com/voronkovich/gitignore.plugin.zsh.git / plugin true' 'https://github.com/jeffreytse/zsh-vi-mode.git / plugin true' 'https://github.com/zsh-users/zsh-syntax-highlighting.git / plugin true' 'https://github.com/zsh-users/zsh-autosuggestions.git / plugin true' 'https://github.com/romkatv/powerlevel10k.git / theme true')
typeset -g _ANTIGEN_CACHE_LOADED; _ANTIGEN_CACHE_LOADED=true
typeset -ga _ZCACHE_BUNDLE_SOURCE; _ZCACHE_BUNDLE_SOURCE=('/home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/git' '/home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/git/git.plugin.zsh' '/home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract' '/home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract/extract.plugin.zsh' '/home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmux' '/home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmux/tmux.plugin.zsh' '/home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/z' '/home/astro/.zsh/antigen/bundles/robbyrussell/oh-my-zsh/plugins/z/z.plugin.zsh' '/home/astro/.zsh/antigen/bundles/voronkovich/gitignore.plugin.zsh//' '/home/astro/.zsh/antigen/bundles/voronkovich/gitignore.plugin.zsh///gitignore.plugin.zsh' '/home/astro/.zsh/antigen/bundles/jeffreytse/zsh-vi-mode//' '/home/astro/.zsh/antigen/bundles/jeffreytse/zsh-vi-mode///zsh-vi-mode.plugin.zsh' '/home/astro/.zsh/antigen/bundles/zsh-users/zsh-syntax-highlighting//' '/home/astro/.zsh/antigen/bundles/zsh-users/zsh-syntax-highlighting///zsh-syntax-highlighting.plugin.zsh' '/home/astro/.zsh/antigen/bundles/zsh-users/zsh-autosuggestions//' '/home/astro/.zsh/antigen/bundles/zsh-users/zsh-autosuggestions///zsh-autosuggestions.plugin.zsh' '/home/astro/.zsh/antigen/bundles/romkatv/powerlevel10k//' '/home/astro/.zsh/antigen/bundles/romkatv/powerlevel10k///powerlevel10k.zsh-theme')
typeset -g _ANTIGEN_CACHE_VERSION; _ANTIGEN_CACHE_VERSION='v2.2.2'

#-- END ZCACHE GENERATED FILE
