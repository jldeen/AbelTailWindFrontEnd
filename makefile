BRANCH ?= bgcolor
SUBSCRIPTION ?= "AbelSubscription"
RG ?= AbelIgnite2018WServers
webappName ?= AbelTailWindFrontEnd4

.PHONY: delete-branch delete-deploymentSlot git-clean

all:
	-make delete-branch
	-make delete-deploymentSlot
	-make git-clean 

delete-branch: 
	-git branch -d $(BRANCH)
	-git push origin -d $(BRANCH) && echo "$(branch) branch successfully deleted"
	-git fetch --prune

delete-deploymentSlot:
	-az account set -s $(SUBSCRIPTION)
	-az webapp traffic-routing clear -n $(webappName) -g $(RG)
	-az webapp deployment slot delete -s canary -n $(webappName)  -g $(RG)

git-clean:
	-git branch master
	-git rm azure-pipelines.yml
	-git commit -m "reset demo"
	-git push

