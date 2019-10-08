defmodule CarClient do
    use ExUnit.Case
    
    test "start car client to send data" do
     msg1 = "MSH|^~\&|MINDRAY_D-SERIES^00A037009A0053DE^EUI-64||||20190929161510000||ORU^R01^ORU_R01|3938|P|2.6|||AL|NE||UNICODE UTF-8|||IHE_PCD_001^IHE PCD^1.3.6.1.4.1.19376.1.6.1.1.1^ISO
     PID|||^^^Hospital^PI||^^^^^^L
     PV1||I
     OBR|1||3938^MINDRAY_D-SERIES^00A037009A0053DE^EUI-64|CONTINUOUS WAVEFORM|||20190929161509620|20190929161510620
     OBX|1|NA|381^MNDRY_ECG_ELEC_POTL_DEFIB_PADDLE^99MNDRY|1.31.1.381|32767^32767^32767^32767^32767^32767^32767"

     msg2 = "^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767^32767|262656^MDC_DIM_DIMLESS^MDC
     OBX|2|NM|0^MDC_ATTR_SAMP_RATE^MDC|1.31.1.381.1|500|264608^MDC_DIM_PER_SEC^MDC
     OBX|3|NM|2327^MDC_ATTR_NU_MSMT_RES^MDC|1.31.1.381.2|0.000305|266418^MDC_DIM_MILLI_VOLT^MDC
     OBX|4|NM|262196^MDC_EVT_INOP^MDC|1.31.1.381.3|32767
     
     MSH|^~\&|MINDRAY_D-SERIES^00A037009A0053DE^EUI-64||||20190929161510000||ORU^R01^ORU_R01|3939|P|2.6|||AL|N"

     msg3 = "E||UNICODE UTF-8|||IHE_PCD_001^IHE PCD^1.3.6.1.4.1.19376.1.6.1.1.1^ISO
     PID|||^^^Hospital^PI||^^^^^^L
     PV1||I
     OBR|1||3939^MINDRAY_D-SERIES^00A037009A0053DE^EUI-64|CONTINUOUS WAVEFORM|||20190929161509620|20190929161510620
     OBX|1|NA|151780^MDC_IMPED_TTHOR^MDC|1.7.1.151780|0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0|262656^MDC_DIM_DIMLESS^MDC
     OBX|2|NM|0^MDC_ATTR_SAMP_RATE^MDC|1.7.1.151780.1|500|264608^MDC_DIM_PER_SEC^MDC
     OBX|3|NM|2327^MDC_ATTR_NU_MSMT_RES^MDC|1.7.1.151780.2|1.000000|262656^MDC_DIM_DIMLESS^MDC
     OBX|4|NM|262196^MDC_EVT_INOP^MDC|1.7.1.151780.3|32767
     
     MSH|^~\&|MINDRAY_D-SERIES^00A037009A0053DE^EUI-64||||20190929161511000||ORU^R01^ORU_R01|3940|P|2.6|||AL|NE||UNICODE UTF-8|||IHE_PCD_001^IHE PCD^1.3.6.1.4.1.19376.1.6.1.1.1^ISO
     PID|||^^^Hospital^PI||^^^^^^L"
    #  {:ok, socket} = :gen_tcp.connect('localhost', 5000, [:binary])
    #  :gen_tcp.send(socket, msg1)
    #  :gen_tcp.send(socket, msg2)
    #  :gen_tcp.send(socket, msg3)
    end
  end