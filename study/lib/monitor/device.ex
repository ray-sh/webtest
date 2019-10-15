defmodule DeviceInfo do
    defstruct [
        :id,
        :time_stamp,
        :heart_beat, #MDC_ECG_HEART_RATE
        :breath,     #MDC_TTHOR_RESP_RATE
        :ecg_wave,      #MDC_ECG_ELEC_POTL_II
        :tthor_wave       #MDC_IMPED_TTHOR, Transthoracic Impedance(经胸阻抗)
    ]

    def merge(pre_dev, dev) do
       %DeviceInfo{
           id: ors(pre_dev.id, dev.id),
           time_stamp: ors(pre_dev.time_stamp, dev.time_stamp),
           heart_beat: ors(pre_dev.heart_beat, dev.heart_beat),
           breath: ors(pre_dev.breath, dev.breath),
           ecg_wave: ors(pre_dev.ecg_wave, dev.ecg_wave),
           tthor_wave: ors(pre_dev.tthor_wave, dev.tthor_wave),
        }
    end

    def ors(a,b), do: a || b
end