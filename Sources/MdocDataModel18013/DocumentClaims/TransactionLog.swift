/*
Copyright (c) 2026 European Commission

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import Foundation
/// Transaction log.
public struct TransactionLog: Sendable, Codable {
	public init(timestamp: Int64, status: Status, errorMessage: String? = nil, rawRequest: Data? = nil, rawResponse: Data? = nil, relyingParty: RelyingParty? = nil, issuingParty: IssuingParty? = nil, type: TransactionLog.LogType, dataFormat: TransactionLog.DataFormat, sessionTranscript: Data? = nil, docMetadata: [Data?]? = nil, documentId: String? = nil, docType: String? = nil, displayName: String? = nil) {
		// Initialize the properties with the provided values
		self.timestamp = timestamp
		self.status = status
		self.errorMessage = errorMessage
		self.rawRequest = rawRequest
		self.rawResponse = rawResponse
		self.relyingParty = relyingParty
		self.issuingParty = issuingParty
		self.type = type
		self.dataFormat = dataFormat
		self.sessionTranscript = sessionTranscript
		self.docMetadata = docMetadata
		self.documentId = documentId
		self.docType = docType
		self.displayName = displayName
	}

	public let timestamp: Int64
	public let status: Status
	public let errorMessage: String?
	public let rawRequest: Data?
	public let rawResponse: Data?
	public let relyingParty: RelyingParty?
	public let issuingParty: IssuingParty?
	public let type: LogType
	public let dataFormat: DataFormat
	public let sessionTranscript: Data?
	public let docMetadata: [Data?]?
	public let documentId: String?
	public let docType: String?
	public let displayName: String?

	public enum DataFormat: Int, Sendable, Codable {
		case cbor
		case json

		public init(_ format: DocDataFormat) {
			switch format {
			case .cbor: self = .cbor
			case .sdjwt: self = .json
			}
		}
	}

    public struct RelyingParty: Codable, Sendable {
        public init(name: String, isVerified: Bool, certificateChain: [Data], readerAuth: Data? = nil) {
            self.name = name
            self.isVerified = isVerified
            self.certificateChain = certificateChain
            self.readerAuth = readerAuth
        }
        
		/// The name of the relying party
		public let name: String
		/// Whether the relying party is verified.
		public let isVerified: Bool
		/// The certificate chain of the relying party.
		public let certificateChain: [Data]
		/// The reader authentication data. This is populated only when mdoc presentation is used.
		public let readerAuth: Data?
	}

    public struct IssuingParty: Codable, Sendable {
        public init(name: String, identifier: String, logoUrl: String? = nil) {
            self.name = name
            self.identifier = identifier
            self.logoUrl = logoUrl
        }
        
		public let name: String
		public let identifier: String
		public let logoUrl: String?
	}

	public enum LogType: Int, Sendable, Codable {
		case presentation
		case issuance
		case signing
		case deletion
	}

	public enum Status: Int, Sendable, Codable {
		/// Indicates that the transaction is incomplete
		case incomplete
		// Indicates that the transaction was completed successfully.
		case completed
		// Indicates that the transaction failed.
		case failed
	}

	public func copy(timestamp: Int64) -> Self { .init(timestamp: timestamp, status: status, errorMessage: errorMessage, rawRequest: rawRequest, rawResponse: rawResponse, relyingParty: relyingParty, issuingParty: issuingParty, type: type, dataFormat: dataFormat, sessionTranscript: sessionTranscript, docMetadata: docMetadata, documentId: documentId, docType: docType, displayName: displayName) }
	public func copy(status: Status) -> Self { .init(timestamp: timestamp, status: status, errorMessage: errorMessage, rawRequest: rawRequest, rawResponse: rawResponse, relyingParty: relyingParty, issuingParty: issuingParty, type: type, dataFormat: dataFormat, sessionTranscript: sessionTranscript, docMetadata: docMetadata, documentId: documentId, docType: docType, displayName: displayName) }
	public func copy(errorMessage: String?) -> Self { .init(timestamp: timestamp, status: status, errorMessage: errorMessage, rawRequest: rawRequest, rawResponse: rawResponse, relyingParty: relyingParty, issuingParty: issuingParty, type: type, dataFormat: dataFormat, sessionTranscript: sessionTranscript, docMetadata: docMetadata, documentId: documentId, docType: docType, displayName: displayName) }
	public func copy(rawRequest: Data?) -> Self { .init(timestamp: timestamp, status: status, errorMessage: errorMessage, rawRequest: rawRequest, rawResponse: rawResponse, relyingParty: relyingParty, issuingParty: issuingParty, type: type, dataFormat: dataFormat, sessionTranscript: sessionTranscript, docMetadata: docMetadata, documentId: documentId, docType: docType, displayName: displayName) }
	public func copy(rawResponse: Data?) -> Self { .init(timestamp: timestamp, status: status, errorMessage: errorMessage, rawRequest: rawRequest, rawResponse: rawResponse, relyingParty: relyingParty, issuingParty: issuingParty, type: type, dataFormat: dataFormat, sessionTranscript: sessionTranscript, docMetadata: docMetadata, documentId: documentId, docType: docType, displayName: displayName) }
	public func copy(relyingParty: RelyingParty?) -> Self { .init(timestamp: timestamp, status: status, errorMessage: errorMessage, rawRequest: rawRequest, rawResponse: rawResponse, relyingParty: relyingParty, issuingParty: issuingParty, type: type, dataFormat: dataFormat, sessionTranscript: sessionTranscript, docMetadata: docMetadata, documentId: documentId, docType: docType, displayName: displayName) }
	public func copy(issuingParty: IssuingParty?) -> Self { .init(timestamp: timestamp, status: status, errorMessage: errorMessage, rawRequest: rawRequest, rawResponse: rawResponse, relyingParty: relyingParty, issuingParty: issuingParty, type: type, dataFormat: dataFormat, sessionTranscript: sessionTranscript, docMetadata: docMetadata, documentId: documentId, docType: docType, displayName: displayName) }
	public func copy(type: LogType) -> Self { .init(timestamp: timestamp, status: status, errorMessage: errorMessage, rawRequest: rawRequest, rawResponse: rawResponse, relyingParty: relyingParty, issuingParty: issuingParty, type: type, dataFormat: dataFormat, sessionTranscript: sessionTranscript, docMetadata: docMetadata, documentId: documentId, docType: docType, displayName: displayName) }
	public func copy(dataFormat: DataFormat) -> Self { .init(timestamp: timestamp, status: status, errorMessage: errorMessage, rawRequest: rawRequest, rawResponse: rawResponse, relyingParty: relyingParty, issuingParty: issuingParty, type: type, dataFormat: dataFormat, sessionTranscript: sessionTranscript, docMetadata: docMetadata, documentId: documentId, docType: docType, displayName: displayName) }
	public func copy(sessionTranscript: Data?) -> Self { .init(timestamp: timestamp, status: status, errorMessage: errorMessage, rawRequest: rawRequest, rawResponse: rawResponse, relyingParty: relyingParty, issuingParty: issuingParty, type: type, dataFormat: dataFormat, sessionTranscript: sessionTranscript, docMetadata: docMetadata, documentId: documentId, docType: docType, displayName: displayName) }
	public func copy(docMetadata: [Data?]?) -> Self { .init(timestamp: timestamp, status: status, errorMessage: errorMessage, rawRequest: rawRequest, rawResponse: rawResponse, relyingParty: relyingParty, issuingParty: issuingParty, type: type, dataFormat: dataFormat, sessionTranscript: sessionTranscript, docMetadata: docMetadata, documentId: documentId, docType: docType, displayName: displayName) }
	public func copy(documentId: String?) -> Self { .init(timestamp: timestamp, status: status, errorMessage: errorMessage, rawRequest: rawRequest, rawResponse: rawResponse, relyingParty: relyingParty, issuingParty: issuingParty, type: type, dataFormat: dataFormat, sessionTranscript: sessionTranscript, docMetadata: docMetadata, documentId: documentId, docType: docType, displayName: displayName) }
	public func copy(docType: String?) -> Self { .init(timestamp: timestamp, status: status, errorMessage: errorMessage, rawRequest: rawRequest, rawResponse: rawResponse, relyingParty: relyingParty, issuingParty: issuingParty, type: type, dataFormat: dataFormat, sessionTranscript: sessionTranscript, docMetadata: docMetadata, documentId: documentId, docType: docType, displayName: displayName) }
	public func copy(displayName: String?) -> Self { .init(timestamp: timestamp, status: status, errorMessage: errorMessage, rawRequest: rawRequest, rawResponse: rawResponse, relyingParty: relyingParty, issuingParty: issuingParty, type: type, dataFormat: dataFormat, sessionTranscript: sessionTranscript, docMetadata: docMetadata, documentId: documentId, docType: docType, displayName: displayName) }

	public func copy(timestamp: Int64? = nil, status: Status? = nil, errorMessage: String? = nil, rawRequest: Data? = nil, rawResponse: Data? = nil, relyingParty: RelyingParty? = nil, issuingParty: IssuingParty? = nil, type: LogType? = nil, dataFormat: DataFormat? = nil, sessionTranscript: Data? = nil, docMetadata: [Data?]? = nil, documentId: String? = nil, docType: String? = nil, displayName: String? = nil) -> Self {
		.init(timestamp: timestamp ?? self.timestamp, status: status ?? self.status, errorMessage: errorMessage ?? self.errorMessage, rawRequest: rawRequest ?? self.rawRequest, rawResponse: rawResponse ?? self.rawResponse, relyingParty: relyingParty ?? self.relyingParty, issuingParty: issuingParty ?? self.issuingParty, type: type ?? self.type, dataFormat: dataFormat ?? self.dataFormat, sessionTranscript: sessionTranscript ?? self.sessionTranscript, docMetadata: docMetadata ?? self.docMetadata, documentId: documentId ?? self.documentId, docType: docType ?? self.docType, displayName: displayName ?? self.displayName)
	}
}
