FROM grafana/grafana

MAINTAINER duncau1234@gmail.com

WORKDIR /tmp

RUN apt-get update && apt-get install -y git

COPY ./grafana.ini /etc/grafana/

COPY ./dashboards/ /var/lib/grafana/dashboards

RUN chown -R grafana:grafana /etc/grafana/ && chown -R grafana:grafana /var/lib/grafana/

RUN sed -i 's/step_input:""/step_input:c.target.step/; s/ HH:MM/ HH:mm/; s/,function(c)/,"templateSrv",function(c,g)/; s/expr:c.target.expr/expr:g.replace(c.target.expr,c.panel.scopedVars)/' /usr/share/grafana/public/app/plugins/datasource/prometheus/query_ctrl.js \

&& sed -i 's/h=a.interval/h=g.replace(a.interval, c.scopedVars)/' /usr/share/grafana/public/app/plugins/datasource/prometheus/datasource.js

VOLUME ["/grafana_data"]

EXPOSE 3000



