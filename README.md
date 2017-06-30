# Zabbix Unifi Video

These scripts allow you monitor your Unifi NVR status and cameras.
It use API of Unifi NVR and automatic discovery all connected cams.
Metrics: monitoring state of cameras (connected or disconnected) and time of last record of each camera (by default trigger set to > 10 minutes)

## Installation
For Debian, maybe packages name in Ubuntu the same.

`apt-get install ruby ruby-dev gcc g++ make`

`gem install rest-client`

After it place all *.rb scripts to /etc/zabbix/externalscripts/ (create this directory)

Add to scripts your NVR url and API key.

Add following user parameters to /etc/zabbix/zabbix_agentd.conf:

```
UserParameter=nvr.cam_list,/etc/zabbix/externalscripts/nvr_cam_discovery.rb
UserParameter=nvr.cam_alive[*],/etc/zabbix/externalscripts/nvr_cam_alive.rb $1
UserParameter=nvr.cam_last_record[*],/etc/zabbix/externalscripts/nvr_cam_lastrecord.rb $1
```

And restart Zabbix agent.
After it import zbx_univi_video_template.xml to Zabbix (Configuration - Templates - Import). And apply it to NVR host.
