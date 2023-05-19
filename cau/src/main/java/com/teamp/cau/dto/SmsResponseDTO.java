package com.teamp.cau.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
@Data
public class SmsResponseDTO {
	String requestId;
	LocalDateTime requestTime;
	String statusCode;
	String statusName;
}
