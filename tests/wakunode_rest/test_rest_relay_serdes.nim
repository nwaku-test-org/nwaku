{.used.}

import
  stew/[results, byteutils],
  chronicles,
  unittest2,
  json_serialization
import
  ../../waku/common/base64,
  ../../waku/node/rest/serdes,
  ../../waku/node/rest/relay/types,
  ../../waku/waku_core



suite "Waku v2 Rest API - Relay - serialization":

  suite "RelayWakuMessage - decode":
    test "optional fields are not provided":
      # Given
      let payload = base64.encode("MESSAGE")
      let jsonBytes = toBytes("{\"payload\":\"" & $payload & "\"}")

      # When
      let res = decodeFromJsonBytes(RelayWakuMessage, jsonBytes, requireAllFields = true)

      # Then
      require(res.isOk())
      let value = res.get()
      check:
        value.payload == payload
        value.contentTopic.isNone()
        value.version.isNone()
        value.timestamp.isNone()

  suite "RelayWakuMessage - encode":
    test "optional fields are none":
      # Given
      let payload = base64.encode("MESSAGE")
      let data = RelayWakuMessage(
        payload: payload,
        contentTopic: none(ContentTopic),
        version: none(Natural),
        timestamp: none(int64)
      )

      # When
      let res = encodeIntoJsonBytes(data)

      # Then
      require(res.isOk())
      let value = res.get()
      check:
        value == toBytes("{\"payload\":\"" & $payload & "\"}")
