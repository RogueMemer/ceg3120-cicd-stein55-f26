# ceg3120-cicd-stein55-f26
### Local Container Test

This screenshot shows the Docker container running and serving the website through Apache on port 8080.
<img width="1872" height="1338" alt="Screenshot_4-11-2026_125230_localhost" src="https://github.com/user-attachments/assets/cecf9cae-4542-4079-8b3e-3f7791d799e6" />
<img width="958" height="373" alt="Screenshot 2026-11-04 155059" src="https://github.com/user-attachments/assets/538da9be-09d6-4c42-bc50-814969c74e91" />
<img width="953" height="468" alt="image png" src="https://github.com/user-attachments/assets/41dd0f48-765e-4435-a974-2ec907154089" />
<img width="943" height="55" alt="Screenshot 2026-11-04 153820" src="https://github.com/user-attachments/assets/6802a1bd-4148-43aa-b4f9-7bb119514fa3" />

test

ceg3120-cicd-stein55-f26
Local Container Test
This screenshot shows the Docker container running and serving the website through Apache on port 8080.
# Part 2
  * <ul><li>A DockerHub Personal Access Token (PAT) was created through DockerHub Account Settings → Personal Access Tokens. The PAT was given Read, Write, and Delete permissions.</li><li>Settings -> Secrets and Variables -> Actions</li><li>DOCKER_USERNAME - Stores the DockerHub username.</li><li>DOCKER_TOKEN - Stores the DockerHub Personal Access Token used for DockerHub authentication.</li><li>The workflow triggers whenever a commit is pushed to the main branch.</li><li>Checkout repository. -> Login to DockerHub. -> Build Docker image. -> Push image to DockerHub.</li><li>The DockerHub username, DockerHub repository name, secret values, and branch name would need to be updated.</li><li>The changes in workflow was configured to trigger on pushes to main, authenticate with DockerHub using secrets, build a Docker image, and push the image to DockerHub.</li><li>Changes in repository were GitHub Actions workflow, DOCKER_USERNAME secret, DOCKER_TOKEN secret.</li><li>Workflow permalink: https://github.com/RogueMemer/ceg3120-cicd-stein55-f26/blob/main/.github/workflows/docker.yml </li><li>To test that the workflow did its tasking, I pushed a commit to the main branch and checked the GitHub Actions tab to verify that the workflow ran successfully.</li><li>How to verify the DockerHub image is running: docker pull roguememer/aboutme-site:latest</li></ul>Run image: docker run -d -p 8080:80 --name aboutme-site roguememer/aboutme-site:latest
Open: http://127.0.0.1:8080 
<ul><li>DockerHub Repository: https://hub.docker.com/r/roguememer/aboutme-site </li><li>Website Content: https://github.com/RogueMemer/ceg3120-cicd-stein55-f26/blob/main/web-content/index.html </li></ul>

# Part 3
  * <ul><li>To see tags in a git repository: git tag</li><li>To see details of a tag and the commit it points to: git show v1.0.0</li><li>To generate an annotated tag on the most recent commit: git tag -a v1.0.0 -m "First release"</li><li>To push a single tag to GitHub: git push origin v1.0.0</li><li>To push all local tags to GitHub: git push origin --tags</li><li>Tags follow semantic versioning (MAJOR.MINOR.PATCH). Releases created: v1.0.0, v1.1.0, v1.2.0, v1.3.0.</li></ul>Semantic Versioning Container Images with GitHub Actions
<ul><li>The workflow triggers whenever a tag matching v*.*.* is pushed to the repository. Pushes to branches no longer trigger it.</li><li>Checkout repository. -> Login to DockerHub using secrets. -> Generate tags with docker/metadata-action. -> Set up Docker Buildx. -> Build and push image to DockerHub.</li><li>docker/metadata-action reads the pushed git tag and generates the image tags. For example, pushing v1.3.0 produces latest, 1, and 1.3.</li><li>Values that would need to be updated in a different repository:</li><li><ul><li>Workflow: the images: value (roguememer/aboutme-site) must be changed to the new DockerHub username and repository name. The tag pattern in on: push: tags: can be changed if a different version format is used.</li><li>Repository: the DOCKER_USERNAME and DOCKER_TOKEN secrets must be created in Settings -> Secrets and Variables -> Actions. A Dockerfile must exist in the repository, and the context path must match its location.</li></ul></li><li>Workflow permalink: https://github.com/RogueMemer/ceg3120-cicd-stein55-f26/blob/main/.github/workflows/docker.yml </li></ul>Testing & Validating
<ul><li>To test that the workflow did its tasking, I pushed a new tag (git push origin v1.3.0), opened the GitHub Actions tab, and verified that the run triggered by the tag completed with all steps green.</li><li>I then checked the Tags page on DockerHub to confirm latest, 1, 1.0, 1.1, 1.2, and 1.3 were present.</li><li>How to verify the DockerHub image is running: docker pull roguememer/aboutme-site:1.0 docker pull roguememer/aboutme-site:1.3</li></ul>Run images: docker run -d --rm --name site10 -p 8080:80 roguememer/aboutme-site:1.0 docker run -d --rm --name site13 -p 8081:80 roguememer/aboutme-site:1.3
Open: http://127.0.0.1:8080 (1.0, shows <:)>) http://127.0.0.1:8081 (1.3, shows <"We master all that lies before">)
Stop containers: docker stop site10 site13
<ul><li>Visible change between releases: 1.0 still serves the original site while 1.3 serves the updated text, which shows a new release does not overwrite the previous version and that rolling back to 1.0 is possible.</li><li>DockerHub Repository (tag set): https://hub.docker.com/r/roguememer/aboutme-site/tags </li></ul>
  
# Part 4 - Project Overview and Diagram
 
* The goal of this project was to create a website, containerize it using Docker, and automate building and publishing images to DockerHub using GitHub Actions. This allows changes pushed to GitHub to automatically build and publish updated container images.
 
* Tools used in this project:
* GitHub - Stores the repository and source code.
* GitHub Actions - Automates building and pushing Docker images.
* Docker - Creates and runs containers.
* DockerHub - Stores Docker images and image versions.
* Apache HTTPD - Serves the website inside the container.
 
* Project Diagram:
 
```text
Local Repository
|
v
GitHub
|
v
GitHub Actions
|
v
Build Docker Image
|
v
DockerHub
|
v
Docker Container
|
v
Website
```

* copilot helped me fix errors that I made an example would be *insert error code* Help me solve this error code
* <img width="959" height="501" alt="Screenshot 2026-11-05 174142" src="https://github.com/user-attachments/assets/a0fc6d14-d39a-4751-b19a-23dc4e05c66b" />
<img width="1879" height="977" alt="Screenshot_5-11-2026_174750_github com" src="https://github.com/user-attachments/assets/b8a8ea2b-e299-444a-bc6c-cfb4b77c507a" />
<img width="1903" height="827" alt="Screenshot_4-11-2026_153317_localhost" src="https://github.com/user-attachments/assets/d2178789-bbae-4600-af91-6c9181866049" />
<img width="943" height="55" alt="Screenshot 2026-11-04 153820" src="https://github.com/user-attachments/assets/d285b8d2-fc01-465f-8111-cfe26fa28079" />
<img width="953" height="468" alt="image png" src="https://github.com/user-attachments/assets/fd37b0e1-218d-440a-a355-e13a99192e22" />
<img width="1875" height="2042" alt="Screenshot_4-11-2026_182036_hub docker com" src="https://github.com/user-attachments/assets/f22a1578-b7ff-47d5-ac6b-14f0604bfa0a" />
<img width="1882" height="1055" alt="Screenshot_4-11-2026_182054_github com" src="https://github.com/user-attachments/assets/3b16f966-0fc3-41de-9c73-97f35911b8b9" />
<img width="1884" height="2418" alt="Screenshot_4-11-2026_182915_github com" src="https://github.com/user-attachments/assets/dea504ce-210d-40a6-805a-912ce558eb95" />
<img width="958" height="373" alt="Screenshot 2026-11-04 155059" src="https://github.com/user-attachments/assets/40f31874-9d76-4d1d-b5c9-598b0c3bd737" />
<img width="953" height="469" alt="Screenshot 2026-11-04 185325" src="https://github.com/user-attachments/assets/c54f2486-3d92-4e58-bb36-c83b3c331f38" />
<img width="1879" height="1671" alt="Screenshot_5-11-2026_113626_github com" src="https://github.com/user-attachments/assets/92dbe0b0-92f6-45f3-9934-0f088a4da25d" />
<img width="957" height="470" alt="Screenshot 2026-11-05 121314" src="https://github.com/user-attachments/assets/ef5fd37e-03ab-496e-a519-8884b2ac6611" />
<img width="959" height="468" alt="Screenshot 2026-11-05 164514" src="https://github.com/user-attachments/assets/3bd86ae1-b8ac-46ee-b3f3-e88dc0073ab5" />
<img width="956" height="472" alt="Screenshot 2026-11-05 165010" src="https://github.com/user-attachments/assets/4229b156-ad5d-46a5-8829-4985b66b93ba" />
<img width="1882" height="1383" alt="Screenshot_5-11-2026_173340_github com" src="https://github.com/user-attachments/assets/a609867f-a409-4639-9194-e789dac25547" />
<img width="726" height="458" alt="Screenshot 2026-11-05 173908" src="https://github.com/user-attachments/assets/5525558a-cce5-4ad1-819f-f1365a7cf5c6" />

I accidentally lost the OG rehub so this is the testing branch

https://github.com/RogueMemer/ceg3120-cicd-stein55-f26/tree/main is the repo I'm using
