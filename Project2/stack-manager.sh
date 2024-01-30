#!/bin/bash
read -p $'Select the required action to be executed \n 1. Deploy Network Stack \n 2. Preview Network Stack \n 3. Delete Network Stack \n 4. Deploy Application Stack \n 5. Preview Application Stack \n 6. Delete Application Stack \n 7. Exit \n Enter option: ' ACTION
echo $ACTION

deploy()
{
    read -p "Enter Stack Name:" STACKNAME
    read -p "Enter Template filename:" TEMPLATENAME
    read -p "Enter Parameter filename:" PARAMNAME

}

delete()
{
    read -p "Enter Stack Name:" STACKNAME
    echo $STACKNAME
}

case $ACTION in

    "1")
    deploy
    echo "aws cloudformation deploy --stack-name $STACKNAME --template-file $TEMPLATENAME --parameter-overrides file://$PARAMNAME"
    aws cloudformation deploy --stack-name $STACKNAME --template-file $TEMPLATENAME --parameter-overrides file://$PARAMNAME
    ;;

    "2")
    deploy
    echo "aws cloudformation deploy --stack-name $STACKNAME --template-file $TEMPLATENAME --parameter-overrides file://$PARAMNAME --capabilities "CAPABILITY_NAMED_IAM" --no-execute-changeset"
    aws cloudformation deploy --stack-name $STACKNAME --template-file $TEMPLATENAME --parameter-overrides file://$PARAMNAME --capabilities "CAPABILITY_NAMED_IAM" --no-execute-changeset
    ;;

    "3")
    delete
    echo "aws cloudformation delete-stack --stack-name $STACKNAME"
    aws cloudformation delete-stack --stack-name $STACKNAME
    ;;

    "4")
    deploy
    echo "aws cloudformation deploy --stack-name $STACKNAME --template-file $TEMPLATENAME --parameter-overrides file://$PARAMNAME --capabilities "CAPABILITY_NAMED_IAM""
    aws cloudformation deploy --stack-name $STACKNAME --template-file $TEMPLATENAME --parameter-overrides file://$PARAMNAME --capabilities "CAPABILITY_NAMED_IAM"
    ;;

    "5")
    deploy
    echo "aws cloudformation deploy --stack-name $STACKNAME --template-file $TEMPLATENAME --parameter-overrides file://$PARAMNAME --capabilities "CAPABILITY_NAMED_IAM" --no-execute-changeset"
    aws cloudformation deploy --stack-name $STACKNAME --template-file $TEMPLATENAME --parameter-overrides file://$PARAMNAME --capabilities "CAPABILITY_NAMED_IAM" --no-execute-changeset
    ;;

    "6")
    delete
    echo "aws cloudformation delete-stack --stack-name $STACKNAME"
    aws s3api delete-objects --bucket udagram-app-bucket --delete "$(aws s3api list-object-versions --bucket "udagram-app-bucket" --output=json --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')"
    aws cloudformation delete-stack --stack-name $STACKNAME
    ;;

    "7")
    echo "Exiting.."
    exit
    ;;

    *)
    echo "Invalid option"
    exit
    ;;

    esac   


