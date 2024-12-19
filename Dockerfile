FROM gists/frp:latest
CMD ["/usr/bin/frps","-c","/etc/frps.toml"]