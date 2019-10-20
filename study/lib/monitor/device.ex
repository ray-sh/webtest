defmodule DeviceInfo do
  @derive [Jason.Encoder]
  defstruct [
    :id,
    :time_stamp,
    # MDC_ECG_HEART_RATE
    :heart_beat,
    # MDC_TTHOR_RESP_RATE
    :breath,
    # MDC_ECG_ELEC_POTL_II
    :ecg_wave,
    # MDC_IMPED_TTHOR, Transthoracic Impedance(经胸阻抗)
    :tthor_wave
  ]

  def merge(pre_dev, dev) do
    %DeviceInfo{
      id: ors(pre_dev.id, dev.id),
      time_stamp: ors(pre_dev.time_stamp, dev.time_stamp),
      heart_beat: ors(pre_dev.heart_beat, dev.heart_beat),
      breath: ors(pre_dev.breath, dev.breath),
      ecg_wave: ors(pre_dev.ecg_wave, dev.ecg_wave),
      tthor_wave: ors(pre_dev.tthor_wave, dev.tthor_wave)
    }
  end

  def ors(a, b), do: a || b
end
