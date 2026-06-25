{ config, pkgs, ... }:

{
  programs.vim = {
    enable = true;
    defaultEditor = true;

    settings = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      ignorecase = true;
      smartcase = true;
      background = "dark";
    };

    extraConfig = ''
      syntax on
      set mouse=a
      set clipboard=unnamedplus
      set wrap
      set linebreak
      set scrolloff=8
      set laststatus=2
      set wildmenu
      set wildmode=longest,list
      set autoindent
      set smartindent
      set cursorline
      set showmatch
      set incsearch
      set hlsearch
      set encoding=utf-8

      " Leader
      let mapleader = " "

      " File operations
      nnoremap <leader>w :w<CR>
      nnoremap <leader>q :q<CR>
      nnoremap <leader>n :nohl<CR>

      " Window navigation
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      " Navigate wrapped lines naturally
      nnoremap j gj
      nnoremap k gk

      " Keep cursor centered during search and scroll
      nnoremap n nzzzv
      nnoremap N Nzzzv
      nnoremap <C-d> <C-d>zz
      nnoremap <C-u> <C-u>zz

      " Stay in visual mode after indent
      vnoremap < <gv
      vnoremap > >gv
    '';
  };
}
