script_dir=$(dirname "$0")

action=create-stack
if [ "$1" == "update" ]; then
  action=update-stack
fi

aws cloudformation $action \
  --capabilities CAPABILITY_IAM \
  --stack-name codepipeline-skeleton-bootstrap \
  --template-body file://$script_dir/../iac/bootstrap.yaml
  
