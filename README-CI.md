# ceg3120-cicd-stein55-f26
### Local Container Test


This screenshot shows the Docker container running and serving the website through Apache on port 8080.
<img width="1872" height="1338" alt="Screenshot_4-11-2026_125230_localhost" src="https://github.com/user-attachments/assets/cecf9cae-4542-4079-8b3e-3f7791d799e6" />
<img width="958" height="373" alt="Screenshot 2026-11-04 155059" src="https://github.com/user-attachments/assets/538da9be-09d6-4c42-bc50-814969c74e91" />
<img width="953" height="468" alt="image png" src="https://github.com/user-attachments/assets/41dd0f48-765e-4435-a974-2ec907154089" />
<img width="943" height="55" alt="Screenshot 2026-11-04 153820" src="https://github.com/user-attachments/assets/6802a1bd-4148-43aa-b4f9-7bb119514fa3" />

## Part 2

* A DockerHub Personal Access Token (PAT) was created through DockerHub Account Settings → Personal Access Tokens. The PAT was given Read, Write, and Delete permissions.

* Settings -> Secrets and Variables -> Actions

* DOCKER_USERNAME - Stores the DockerHub username.

* DOCKER_TOKEN - Stores the DockerHub Personal Access Token used for DockerHub authentication.

* The workflow triggers whenever a commit is pushed to the main branch.

* Checkout repository. -> Login to DockerHub. -> Build Docker image. -> Push image to DockerHub.

* The DockerHub username, DockerHub repository name, secret values, and branch name would need to be updated.

* The changes in workflow was configured to trigger on pushes to main, authenticate with DockerHub using secrets, build a Docker image, and push the image to DockerHub.

* Changes in repository were GitHub Actions workflow, DOCKER_USERNAME secret, DOCKER_TOKEN secret.

* Workflow permalink:
https://github.com/RogueMemer/ceg3120-cicd-stein55-f26/blob/main/.github/workflows/docker.yml

* To test that the workflow did its tasking, I pushed a commit to the main branch and checked the GitHub Actions tab to verify that the workflow ran successfully.

* How to verify the DockerHub image is running:
`docker pull roguememer/aboutme-site:latest`

Run image:
`docker run -d -p 8080:80 --name aboutme-site roguememer/aboutme-site:latest`

Open:
http://127.0.0.1:8080

* DockerHub Repository:
https://hub.docker.com/r/roguememer/aboutme-site

* Website Content:
https://github.com/RogueMemer/ceg3120-cicd-stein55-f26/blob/main/web-content/index.html
<img width="957" height="470" alt="Screenshot 2026-11-05 121314" src="https://github.com/user-attachments/assets/e7fc0483-1b13-4d7a-8cf6-00d9f499860e" />
<img width="1875" height="2042" alt="Screenshot_4-11-2026_182036_hub docker com" src="https://github.com/user-attachments/assets/4574cf2f-48e6-426b-bfc7-8451117c7331" />
<img width="1882" height="1055" alt="Screenshot_4-11-2026_182054_github com" src="https://github.com/user-attachments/assets/5e4e909b-2680-4c21-9522-398423a92432" />
<img width="1884" height="2418" alt="Screenshot_4-11-2026_182915_github com" src="https://github.com/user-attachments/assets/4cfbc696-8afe-4f14-b769-8a67cead545a" />
<img width="958" height="373" alt="Screenshot 2026-11-04 155059" src="https://github.com/user-attachments/assets/41ba9ad2-499a-431e-84b3-d194d0fad566" />
<img width="953" height="469" alt="Screenshot 2026-11-04 185325" src="https://github.com/user-attachments/assets/05bccbd0-fa34-4ae7-986b-da919d8c64a8" />
<img width="1879" height="1671" alt="Screenshot_5-11-2026_113626_github com" src="https://github.com/user-attachments/assets/2d22c397-8a90-468a-9493-f86249d12450" />


