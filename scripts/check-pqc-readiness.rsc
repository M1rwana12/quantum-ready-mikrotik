# check-pqc-readiness.rsc
# Проверка: использует ли роутер уязвимые алгоритмы

:local weakAlgos ["rsa" "ecdsa" "dh" "rsa-md5" "rsa-sha1"]
:local vulnerable 0
:local report ""

:foreach i in=[/certificate find] do={
    :local name [/certificate get $i name]
    :local keyType [/certificate get $i key-type]
    :local sig [/certificate get $i signature-algorithm]
    
    :if ([:find $weakAlgos $keyType] >= 0 || [:find $weakAlgos $sig] >= 0) do={
        :set vulnerable ($vulnerable + 1)
        :set report ($report . "УЯЗВИМ: $name ($keyType, $sig)\n")
    }
}

:if ($vulnerable > 0) do={
    :log warning "PQC: Найдено $vulnerable уязвимых сертификатов!"
    :put $report
    :put "ЗАПУСТИ МИГРАЦИЮ: /system script run pqc-migrate"
} else={
    :put "PQC-ГОТОВ! Все алгоритмы квантово-устойчивы."
}
