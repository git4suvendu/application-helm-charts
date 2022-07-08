# game-app

# application-helm-charts


Application Helm Charts

- Game App v0.1.0
- Game App Ingress v0.1.0
- Game App Full  v0.2.0
- Nginx server 0.1.0



Helm Tutorials:

https://helm.sh/docs/topics/chart_repository/

https://medium.com/containerum/how-to-make-and-share-your-own-helm-package-50ae40f6c221

https://stackoverflow.com/questions/62964532/helm-not-creating-the-resources

https://github.com/helm/helm/pull/7649

wkrzywiec.medium.com/deployment-of-multiple-apps-on-kubernetes-cluster-walkthrough-e05d37ed63d1



How to create Custom Helm Charts:

https://medium.com/containerum/how-to-make-and-share-your-own-helm-package-50ae40f6c221


################ Chart Releaser Action #############################

https://github.com/helm/chart-releaser-action

https://helm.sh/docs/howto/chart_releaser_action/#github-actions-workflow

https://lippertmarkus.com/2020/08/13/chartreleaser/


Commands:

helm uninstall game-app-full-rel -n ns-fargate-app

helm install game-app-ingress game-app-ingress/ -n ns-fargate-app --create-namespace 

helm template game-app-full -n ns-fargate-app --debug 

helm repo index application-helm-charts/ --url https://git4suvendu.github.io/application-helm-charts/
