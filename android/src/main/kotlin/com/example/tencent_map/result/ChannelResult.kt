package com.example.tencent_map.result


val successResult: ChannelResult = ChannelResult(true)

val missingParamResult: ChannelResult = ChannelResult(false, "缺少必要参数")

val failedResult: ChannelResult = ChannelResult(false, "操作失败")


/**
 *
 */
data class ChannelResult(val success: Boolean, val message: String = "操作成功", val data: Any? = null) {

    fun toMap(): Map<String, Any?> {
        return mapOf(
                "success" to success,
                "message" to message,
                "data" to data
        )
    }
}

