# Levantando o Ambiente
> Setup do ambiente projetado pelo colega Adriano Carvalho

1. Add to /etc/hosts:

     ` 127.0.0.1 gitlab `

2. Crie a rede que será utilizada

     ```sh
     docker network create cicd-gitlab-network
     ```

3. Crie o volumes do gitlab e do runner

     ```
     docker volume create cicd-gitlab-config
     docker volume create cicd-gitlab-logs
     docker volume create cicd-gitlab-data
     docker volume create cicd-runner-config
     ```

4. Up compose:

     ```sh
     docker compose up -d 
     ```

5. Acesso como root ao gitlab(web)

     - Você pode recuperar a senha inicial utilizando o comando

          ```sh
          sudo cat /var/lib/docker/volumes/cicd-gitlab-config/_data/initial_root_password
          ```
     - Ou você pode já redefinir a senha utilizando o comando

          ```sh
          docker exec -it gitlab gitlab-rails runner "user = User.where(id: 1).first; user.password = 'novasenha'; user.password_confirmation = 'novasenha'; user.save!"
          ```

6. Adicione um novo Runner pelo gitlab:

     - Acesse o Gitlab -> Administracao -> Runners -> New Instance:
          - Marque a opcao "Run untagged jobs" 
          - Clique em **[Create Runner]**

7. Vincule o container docker(runner) com o gitlab:

     ```sh
     # Antes de executar substitua o token
     docker exec -it gitlab-runner gitlab-runner register --url http://gitlab --executor docker --docker-image docker:24.0.5 --token glrt-LUDKJLhqzTzY-H6-xLu8 --docker-privileged -docker-volumes "/certs/client"
     ```

8. Libere a rede na config do runner

     ```sh
     echo '    network_mode = "cicd-gitlab-network"' | sudo tee -a /var/lib/docker/volumes/cicd-runner-config/_data/config.toml
     ```

9. Reinicie o runner

     ```sh 
     docker compose restart gitlab-runner
     ```

10. Criar as variáveis CI/CD no Gitlab para acesso ao Docker HUB

     - DOCKER_HUB_USERNAME
     - DOCKER_HUB_PASSWORD
     - SSH_HOST_DEPLOY
     - SSH_HOST_DEPLOY_USER
     - SSH_HOST_DEPLOY_PASS


<br /><br /><br />

# Gitlab via API 
> Etapa Opicional - Facilita a criação de Projetos, realizando o processo pela linha de comando ao invés de ficar acessando o gitlab.

## Gera token de acesso direto pelo container

```sh
ROOT_TOKEN=$(docker exec -it gitlab gitlab-rails runner "user = User.find_by_username('root'); token = user.personal_access_tokens.create!(scopes: [:api], name: 'Token de Acesso API', expires_at: Time.now + 1.year); puts token.token")
```

## Exportando o URL de acesso a API como variável

```sh
export GL_API="http://gitlab/api/v4" 
```

## Lista os Grupos

```sh
curl --header "PRIVATE-TOKEN: ${ROOT_TOKEN}" "${GL_API}/groups"
```

## Cria o Grupo [ifmt]

```sh
curl --request POST --header "PRIVATE-TOKEN: ${ROOT_TOKEN}" --data "name=ifmt&path=ifmt" "${GL_API}/groups"
```

## Cria o Projeto [cicd]

```sh
# Antes de executar substitua o <ID_GRUPO>
curl --request POST \
     --header "PRIVATE-TOKEN: ${ROOT_TOKEN}" \
     --header "Content-Type: application/json" \
     --data "{\"name\": \"cicd\", \"namespace_id\": <ID_GRUPO>, \"visibility\": \"private\", \"initialize_with_readme\": true}" \
     "${GL_API}/projects"
```
