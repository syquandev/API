//
//  ResponseStatus.swift
//  Network
//
//  Created by Quan on 07/02/2023.
//

import Foundation
import UIKit

public class ResponseStatus: NSObject {

    public var code = ResponseCode.defaultCode
    public var subCode = ResponseCode.defaultCode
    public var message: String = "Unknown"
    public var error: Error?
    public var data: Any?
    public var intVal: Int?
    public var limit: Int?
    
    //MARK - Creator
    
    public init(code:Int?) {
        
        super.init()
        
        guard let code = code else{
            return;
        }
        self.setCode(code)
    }
    
    public static func successReponse() -> ResponseStatus{
        return ResponseStatus(code: ResponseCode.success)
    }
    
    public static func unauthorizedReponse() -> ResponseStatus{
        return ResponseStatus(code: ResponseCode.unauthorized)
    }
    
    public static func errorReponse() -> ResponseStatus{
        return ResponseStatus(code: ResponseCode.noContent)
    }
    
    public static func noContentReponse() -> ResponseStatus{
        return ResponseStatus(code: ResponseCode.noContent)
    }
    
    public override init() {
        super.init()
    }
    
    
    public init(message: String) {
        super.init()
        code = 101
        self.message = message
    }
    
    
    
    public var isError:Bool{
        return code < ResponseCode.success || code > 202 || error != nil
    }
    
    public var isNoContent: Bool{
        return code == 204 || code == 2004
    }
    
    public init(errorMessage:String) {
        super.init()
        code = 101
        message = errorMessage
    }
    
    
    //MARK: - Method
    
    public func setCode(_ code: Int){
        
        self.code = code
        
        switch code {
        case -13:
            message = "Create URL Error"
        case ResponseCode.networkError:
            message = "error_network_request_failed_message"
        case ResponseCode.cancelled:
            message = "Cancelled"
        case ResponseCode.apiError:
            message = "error_internal_message"
        //Successful
        case ResponseCode.success:
            message = "Ok"
        case 201:
            message = "Create"
        case 202:
            message = "Accepted"
        case 203:
            message = "Non-Authoritative Information"
        case ResponseCode.noContent:
            message = "No Content"
        case 205:
            message = "Reset Content"
        case 206:
            message = "Partial Content"
            
        //Redirection 3xx
        case 300:
            message = "Multiple Choices"
        case 301:
            message = "Moved Permanently"
        case 302:
            message = "Found"
        case 303:
            message = "See Other"
        case 304:
            message = "Not Modified"
        case 305:
            message = "Use Proxy"
        case 306:
            message = "Unused"
            
        //Client Error 4xx
        case ResponseCode.badRequest:
            message = "error_bad_request_title"
        case ResponseCode.unauthorized:
            message = "error_unauthorized_title"
        case 402:
            message = "Payment Required"
        case ResponseCode.forbidden:
            message = "error_forbidden_title"
        case ResponseCode.notFound:
            message = "error_not_found_title"
        case ResponseCode.notAllowed:
            message = "error_not_allowed_title"
        case ResponseCode.notAcceptable:
            message = "error_not_accepttable_title"
        case ResponseCode.proxyRequire:
            message = "error_proxy_require_title"
        case ResponseCode.requestTimeout, ResponseCode.systemTimeout:
            self.code = ResponseCode.requestTimeout
            message = "error_request_timeout_message"
        case 409:
            message = "Conflict"
        case 410:
            message = "Unused"
        case 411:
            message = "Length Required"
        case 412:
            message = "Precondition Failed"
        case 413:
            message = "Request Entity Too Large"
        case 414:
            message = "Request-URI Too Long"
        case 415:
            message = "Unsupported Media Type"
        case 416:
            message = "Requested Range Not Satisfiable"
        case 417:
            message = "Expectation Failed"
            
        //Server Error 5xx
        case ResponseCode.internalError:
            message = "Internal Server Error"
        case 501:
            message = "Not Implemented"
        case 502:
            message = "Bad Gateway"
        case 503:
            message = "Service Unavailable"
        case 504:
            message = "Gateway Timeout"
        case 505:
            message = "send_code_wait_few_minutes_error"
            
        case 506:
            message = "send_code_to_many_times_error"
            
        case 610:
            
            message = "register_to_many_time_block_error"
            
        case 8010:
            message = "send_code_to_many_times_block_error"
            
            //HALO
            
        case 701:
            message = "Mail is Exist"
        case 702:
            message = "Exist User"
        case 703:
            message = "Exist Page"
            
        case ResponseCode.dataExist:
            message = "Exist Data"
            
        case ResponseCode.businessConfirm:
            message = "Busines is not confirmed"
            
            ///Wallet
            //        case 8020:
            //            message = "grad_no_wallet_error".localized;
            //
            
        case ResponseCode.tourNotAvailable:
            message = "Tour Not Available"
            
//        case 6002:
//            message = "PAGE NOT YET ACTIVE".localized;
            
        case 10003:
            message = "Expired booking"
            
        case 10002:
            message = "Expired_cancel_order"
            
        case 8014:
            message = "grad_donated_no_wallet_error"
            
        case 8015:
            message = "grad_limited_error"
            
        case 8016:
            message = "grad_password_error"
            
        case 1011:
            message = "live_stream_notice_mess"
            
        case ResponseCode.notExitsInDB:
            message = "Data Not Exist in DB"
            
            
            
            //        case 10035:
            //            message = "grad_invalid_ammount_error".localized;
            
        case ResponseCode.blocked:
            message = "user_blocked_error"
        
        case ResponseCode.limitedFriend:
            message = "user_friend_limited_error"
            
            
            //AUTH
            
        case 1008:
            message = "page_wall_email_er"
        case ResponseCode.unvalidatePhone:
            message = "page_wall_phone_er"
            
        case 10011:
            message = "Wrong information"
            
        case 1020:
            message = "Phone Exists"
            
        case 9002:
            message = "Customer Cart Not Exists"
            
        case 1014:
            message = "handnote_cancel_before_days_error"
            
            
        case 1010:
            message = "response_unauthorized"
            
        case 1009:
            message = "response_invalidate_mail_format"
            
        case 1015:
            message = "response_invalidate_phone_format"
            
        case 1002:
            message = "response_insurance_unavailable"
            
        case ResponseCode.uploadReadError:
            message = "upload_media_read_error"
        default:
            message = "error_internal_message"
        }
    }
    
    public func update2FAMessage(){
        
        switch code {
        case 1015:
            message = "verify_error_wrong_code"
        case 5005:
            message = "verify_error_times"
        default:
            break
        }
    }
    
    public func updateAuthMessage(){
        
        switch code {
        case 1015:
            message = "verify_error_wrong_code"
        case 2004:
            message = "forgot_password_dialog_invalid_body"
        case 4002:
            message = "page_wall_phone_er"
        case 4003:
            message = "page_wall_email_er"
        case 4004:
            message = "update_billing_input_name_not_valid"
        case 4005:
            message = "error_email_exist_message"
        case 5005:
            message = "verify_error_times"
        case 5006:
            message = "verify_error_times_24h"
        default:
            break
        }
    }
    
    public func updateRegisterMessage(){
        switch code {
        case 1015:
            if message == "nv109 equal nv110"{
                message = "Old password and new password cannot be same"
            }else if message == "nn103 expired"{
                message = "verify_error_code_time_out"
            }else if message == "nv103 invalid"{
                message = "verify_code_error"
            }else{
                message = "personal_about_pass_change_fail"
            }
        case 4005:
            message = "error_email_exist_message"
        default:
            break
        }
    }
    public func updateChangePasswordMessage(){
        switch code {
        case 1015:
            if message == "nv109 equal nv110"{
                message = "Old password and new password cannot be same"
            }else{
                message = "personal_about_pass_change_fail"
            }
        default:
            break
        }
    }
}
