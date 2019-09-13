echo "docker rm all dockers ..."
docker stop publish-Grid-Model publish-Grid-Route publish-Grid-Search publish-Grid-Spacdt publish-Grid-Navi publish-Grid-Updatelink
docker rm publish-Grid-Model publish-Grid-Route publish-Grid-Search publish-Grid-Spacdt publish-Grid-Navi publish-Grid-Updatelink
echo "docker deleted!"