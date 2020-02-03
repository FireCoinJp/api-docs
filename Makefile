.PHONY:
start:
	sh server.sh start
deploy:
	./deploy.sh
upload:
	@echo "把build完的文件上传到 https://s3.console.aws.amazon.com/s3/buckets/local-jp-api-docs/?region=ap-northeast-1&tab=overview"
