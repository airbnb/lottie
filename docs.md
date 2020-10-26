## Contributing to the docs directly on GitHub (easy)
Because the Lottie docs are created directly from the markdown in this repo, you can use the GitHub web editor to edit and propose changes to the docs directly from your browser without any knowledge of git.
To do that, find the markdown file with the docs you want to edit and follow [GitHub's instructions](https://docs.github.com/en/free-pro-team@latest/github/managing-files-in-a-repository/editing-files-in-another-users-repository) to edit and propose changes to a markdown file. Once approved, the docs will be updated immediately.

## Contributing to the docs by forking this repo (still pretty easy)
[http://airbnb.io/lottie](http://airbnb.io/lottie) runs on [docsify](https://docsify.js.org/#/?id=docsify). Docsify was chosen because it takes hosted markdown and generates the page dynamically. That means that simply updating the markdown files here is all that is needed to update [http://airbnb.io/lottie](http://airbnb.io/lottie).

1. Fork and clone this repo.
1. Install docsify: `sudo npm instal -g docsify-cli`.
1. Startup the local docsify server with `docsify serve .` from the root of this repo.
1. Edit the markdown and verify your changes on the localhost url outputted from the `docsify serve` command.
1. Put up a pull request to this repo and tag `@gpeal`
1. Enjoy the updated docs!
