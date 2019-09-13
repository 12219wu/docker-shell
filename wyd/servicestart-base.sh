SRC_NAME="grid-map.src"
SERVER="SERVERBASE"
export GOARCH=386
export CGO_ENABLED=1
export GOPATH=$GOPATH:"/go/comgopath":"/go/$SRC_NAME"
cd /go/$SRC_NAME/src/GridService/$SERVER/
cp /go/$SRC_NAME/src/GridService/plugins/*.so* /usr/lib
go build .
./$SERVER
