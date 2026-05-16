# GitHub Pages Deployment Demo

This folder demonstrates deploying a static website to GitHub Pages using a GitHub Actions workflow.

- `index.html`: Simple landing page that says "Hello, GitHub Actions!".
- `.github/workflows/deploy.yml`: Workflow that builds and deploys the site to GitHub Pages when `index.html` changes on the `main` branch.

How it works:

1. Push changes to the `main` branch that modify `index.html`.
2. The workflow uploads the repository files as a Pages artifact and deploys them to GitHub Pages.

Publish URL
-----------

After a successful deployment the site will be available at:

https://<username>.github.io/gh-deployment-workflow/

Replace `<username>` with your GitHub username.

How to publish and verify
-------------------------

1. Commit and push your changes (including `index.html`) to the `main` branch.
2. Open the repository's **Actions** tab and watch the "Deploy to GitHub Pages" workflow run.
3. When the workflow completes, visit the publish URL above to verify the site.
4. If you use a custom domain, add a `CNAME` file to this folder and configure DNS accordingly.

