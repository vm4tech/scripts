function FindProxyForURL(url, host) {
    if (shExpMatch(host, "*.ru") ||
        shExpMatch(host, "*.ru/*") ||
        shExpMatch(host, "*.рф") ||
        shExpMatch(host, "*.рф/*") ||
        shExpMatch(host, "*.su") ||
        shExpMatch(host, "*.tv") ||
        shExpMatch(host, "yandex.*") ||
        shExpMatch(host, "yandex.ru/*") ||
        shExpMatch(host, "*.yandex.*") ||
        shExpMatch(host, "ya.ru") ||
        shExpMatch(host, "vk.com") ||
        shExpMatch(host, "*.vk.com") ||
        shExpMatch(host, "mail.ru") ||
        shExpMatch(host, "*.mail.ru") ||
        shExpMatch(host, "ok.ru") ||
        shExpMatch(host, "*.ok.ru") ||
        shExpMatch(host, "avito.ru") ||
        shExpMatch(host, "*.avito.ru") ||
        shExpMatch(host, "ozon.ru") ||
        shExpMatch(host, "*.ozon.ru") ||
        shExpMatch(host, "wildberries.ru") ||
        shExpMatch(host, "*.wildberries.ru") ||
        shExpMatch(host, "sberbank.ru") ||
        shExpMatch(host, "*.sberbank.ru") ||
        shExpMatch(host, "gosuslugi.ru") ||
        shExpMatch(host, "*.gosuslugi.ru")) {
        return "DIRECT";
    }
    
    if (isPlainHostName(host) ||
        shExpMatch(host, "*.local") ||
        isInNet(host, "10.0.0.0", "255.0.0.0") ||
        isInNet(host, "172.16.0.0", "255.240.0.0") ||
        isInNet(host, "192.168.0.0", "255.255.0.0") ||
        isInNet(host, "127.0.0.0", "255.0.0.0")) {
        return "DIRECT";
    }
    
    return "SOCKS5 127.0.0.1:10808; SOCKS 127.0.0.1:10808; DIRECT";
}
