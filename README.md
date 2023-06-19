# org-roam-download

This extension is based on [`abo-abo/org-downnload`](https://github.com/abo-abo/org-download) and has some functions to work with [`org-roam`](https://www.orgroam.com).

`org-roam-download` stores all images in the `org-roam-download-image-dir`, which is the `images/` under the `org-roam-directory` by default. Since `org-roam` assigns each node (i.e., file) an ID, this extension creates a directory under the `org-roam-download-image-dir` with the ID of this nodeas the name to store all the images referenced by this node. Replace functions prefixed with `org-download-` to `org-roam-download-` should do the job.

- [x] org-roam-download-clipboard $\leftarrow$ org-download-clipboard
- [x] org-roam-download-yank $\leftarrow$ org-download-yank

> Working on other functions... 

## Set up

```elisp
(require 'org-roam-download)

;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)
```

## Pasting from the clipboard
If you have the image stored in the clipboard, use `org-roam-download-clipboard`.

# org-download

> I changed the default value of `org-download-heading-lvl` from `0` to `nil` because of personal preference and for convenience. :)

This extension facilitates moving images from point **A** to point **B**.

Point **A** (*the source*) can be:

1. An image inside your browser that you can drag to Emacs.
2. An image on your file system that you can drag to Emacs.
3. A local or remote image address in kill-ring.
   Use the `org-download-yank` command for this.
   Remember that you can use "0 w" in `dired` to get an address.
4. A screenshot taken using `gnome-screenshot`, `scrot`, `gm`, `xclip`
   (on Linux), `screencapture` (on OS X) or , `imagemagick/convert`
   (on Windows).  Use the `org-download-screenshot` command for this.
   Customize the backend with `org-download-screenshot-method`.

Point **B** (*the target*) is an Emacs `org-mode` buffer where the inline
link will be inserted.  Several customization options will determine
where exactly on the file system the file will be stored.

They are:
`org-download-method`:

1. 'attach => use `org-mode` attachment machinery
2. 'directory => construct the directory in two stages:
   1. first part of the folder name is:
      * either "." (current folder)
      * or `org-download-image-dir` (if it's not nil).

        `org-download-image-dir` becomes buffer-local when set,
        so each file can customize this value, e.g with:

                -*- mode: Org; org-download-image-dir: "~/Pictures/foo"; -*-

        To set it for all files at once, use this:

                (setq-default org-download-image-dir "~/Pictures/foo")


   2. second part is:
      * `org-download-heading-lvl` is nil => ""
      * `org-download-heading-lvl` is n => the name of current
        heading with level n.

        Level count starts with 0,
        i.e. * is 0, ** is 1, *** is 2 etc.
        `org-download-heading-lvl` becomes buffer-local when set,
        so each file can customize this value, e.g with:

                -*- mode: Org; org-download-heading-lvl: nil; -*-

`org-download-timestamp`:
optionally add a timestamp to the file name.

Customize `org-download-backend` to choose between `url-retrieve`
(the default) or `wget` or `curl`.
