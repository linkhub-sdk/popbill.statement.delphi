(*
*=================================================================================
* Unit for base module for Popbill API SDK. It include base functionality for
* RESTful web service request and parse json result. It uses Linkhub module
* to accomplish authentication APIs.
*
* This module uses synapse library.( http://www.ararat.cz/synapse/doku.php/ )
* It's full open source library, free to use include commercial application.
* If you wish to donate that, visit their site.
* So, before using this module, you need to install synapse by user self.
* You can refer their site or detailed infomation about installation is available
* from below our site. We appreciate your visiting.
*
* For strongly secured communications, this module uses SSL/TLS with OpenSSL.
* So You need two dlls (libeay32.dll and ssleay32.dll) from OpenSSL. You can
* get it from Fulgan. ( http://indy.fulgan.com/SSL/ ) We recommend i386_win32 version.
* And also, dlls must be released with your executions. That's the drawback of this
* module, but we acommplished higher security level against that.
*
* http://www.popbill.com
* Author : Kim Seongjun (pallet027@gmail.com)
* Written : 2014-07-17

* Thanks for your interest. 
*=================================================================================
*)
unit PopbillStatement;

interface

uses
        TypInfo,SysUtils,Classes,Dialogs,
        Popbill,
        Linkhub;
type

        TStatementDetail = class
        public
                serialNum       : Integer;
                purchaseDT      : string;
                itemName        : string;
                spec            : string;
                qty             : string;
                _unit           : string;
                unitCost        : string;
                supplyCost      : string;
                tax             : string;
                remark          : string;
                spare1          : string;
                spare2          : string;
                spare3          : string;
                spare4          : string;
                spare5          : string;
        end;
        TDetailList     = Array of TStatementDetail;

        TProperty = class
        public
                name : string;
                value : string;
        end;
        TPropertyList = Array of TProperty;


        TStatement = class
        public
                itemCode             : Integer;

                MgtKey               : string;
                invoiceNum           : string;
                formCode             : string;
                writeDate            : string;
                taxType              : string;

                senderCorpNum        : string;
                senderTaxRegID       : string;
                senderCorpName       : string;
                senderCEOName        : string;
                senderAddr           : string;
                senderBizClass       : string;
                senderBizType        : string;
                senderContactName    : string;
                senderDeptName       : string;
                senderTEL            : string;
                senderHP             : string;
                senderFAX            : string;
                senderEmail          : string;

                receiverCorpNum      : string;
                receiverTaxRegID     : string;
                receiverCorpName     : string;
                receiverCEOName      : string;
                receiverAddr         : string;
                receiverBizClass     : string;
                receiverBizType      : string;
                receiverContactName  : string;
                receiverDeptName     : string;
                receiverTEL          : string;
                receiverHP           : string;
                receiverFAX          : string;
                receiverEmail        : string;

                supplyCostTotal      : string;
                serialNum            : string;
                taxTotal             : string;
                totalAmount          : string;

                purposeType          : string;
                remark1              : string;
                remark2              : string;
                remark3              : string;

                businessLicenseYN    : Boolean;
                bankBookYN           : Boolean;
                faxsendYN            : Boolean;

                SMSSendYN            : Boolean;
                AutoAcceptYN         : Boolean;

                detailList           : TDetailList;
                propertyBag          : TPropertyList;
        end;


        TStatementInfo = class
        public
                ItemCode                : Integer;
                ItemKey                 : string;
                InvoiceNum              : string;
                StateCode               : Integer;
                TaxType                 : string;
                MgtKey                  : string;
                WriteDate               : string;
                purposeType             : string;

                SenderCorpName          : string;
                SenderCorpNum           : string;
                ReceiverCorpName        : string;
                ReceiverCorpNum         : string;

                SupplyCostTotal         : string;
                TaxTotal                : string;

                IssueDT                 : string;
                StateDT                 : string;
                OpenYN                  : boolean;
                OpenDT                  : string;

                StateMemo               : string;

                RegDT                   : string;

        end;

        TStatementInfoList = Array of TStatementInfo;

        TStatementLog = class
        public
                docLogType      : Integer;
                log             : string;
                procType        : string;
                procCorpName    : string;
                procContactName : string;
                procMemo        : string;
                regDT           : string;
                ip              : string;
        end;

        TStatementLogList = Array Of TStatementLog;


        TAttachedFile = class
        public
                SerialNum       : Integer;
                AttachedFile    : String;
                DisplayName     : String;
                RegDT           : string;
        end;

        TAttachedFileList = Array of TAttachedFile;


        TStatementService = class(TPopbillBaseService)
        private                                  
                
                function jsonToTStatementInfo(json : String) : TStatementInfo;
                function jsonToTStatement(json : String) : TStatement;
                function TStatementTojson(Statement : TStatement; Memo : String) : String;
                
        public
                constructor Create(LinkID : String; SecretKey : String);
                //팝필 거래명세서 연결 url.
                function GetURL(CorpNum : String; UserID : String; TOGO : String) : String;

                //관리번호 사용여부 확인
                function CheckMgtKeyInUse(CorpNum : String; ItemCode:Integer; MgtKey : String) : boolean;

                //즉시발행 
                function RegistIssue(CorpNum : String; Statement : TStatement; Memo : String; UserID : String) : TResponse;

                //임시저장.
                function Register(CorpNum : String; Statement : TStatement; UserID : String) : TResponse;
                //수정.
                function Update(CorpNum : String; ItemCode:Integer; MgtKey : String; Statement : TStatement; UserID : String) : TResponse;

                //발행.
                function Issue(CorpNum : String; ItemCode:Integer; MgtKey : String; Memo :String; UserID : String) : TResponse;
                //취소.
                function Cancel(CorpNum : String; ItemCode:Integer; MgtKey : String; Memo : String; UserID : String) : TResponse;
                //삭제.
                function Delete(CorpNum : String; ItemCode:Integer;  MgtKey: String; UserID : String) : TResponse;

                //이메일재전송.
                function SendEmail(CorpNum : String; ItemCode:Integer; MgtKey : String; Receiver:String; UserID : String) : TResponse;
                //문자재전송.
                function SendSMS(CorpNum : String; ItemCode:Integer; MgtKey :String; Sender:String; Receiver:String; Contents : String; UserID : String) : TResponse;
                // 팩스 재전송.
                function SendFAX(CorpNum : String; ItemCode:Integer; MgtKey :String; Sender:String; Receiver:String; UserID : String) : TResponse;

                //세금계산서 요약정보 및 상태정보 확인.
                function GetInfo(CorpNum : string; ItemCode:Integer; MgtKey: string) : TStatementInfo;
                //세금계산서 상세정보 확인
                function GetDetailInfo(CorpNum : string; ItemCode:Integer; MgtKey: string) : TStatement;

                //세금계산서 요약정보 및 상태 다량 확인.
                function GetInfos(CorpNum : string; ItemCode:Integer; MgtKeyList: Array Of String) : TStatementInfoList;
                //문서이력 확인.
                function GetLogs(CorpNum : string; ItemCode:Integer; MgtKey: string) : TStatementLogList;
                //파일 첨부.
                function AttachFile(CorpNum : String; ItemCode:Integer; MgtKey : String; FilePath : String; UserID : String) : TResponse;
                //첨부파일 목록 확인.
                function GetFiles(CorpNum: String; ItemCode:Integer; MgtKey : String) : TAttachedFileList;
                //첨부파일 삭제.
                function DeleteFile(CorpNum: string; ItemCode:Integer; MgtKey : String; FileID : String; UserID : String) : TResponse;
                //팝업URL
                function GetPopUpURL(CorpNum: string; ItemCode:Integer; MgtKey : String; UserID: String) : string;
                //인쇄URL
                function GetPrintURL(CorpNum: string; ItemCode:Integer; MgtKey : String; UserID: String) : string;
                //수신자인쇄URL
                function GetEPrintURL(CorpNum: string; ItemCode:Integer; MgtKey : String; UserID: String) : string;
                //다량인쇄URL
                function GetMassPrintURL(CorpNum: string; ItemCode:Integer; MgtKeyList: Array Of String; UserID: String) : string;

                //Mail URL
                function GetMailURL(CorpNum: string; ItemCode:Integer; MgtKey : String; UserID: String) : string;


                //회원별 세금계산서 발행단가 확인.
                function GetUnitCost(CorpNum : String; ItemCode:Integer) : Single;

        end;


implementation

function PosFrom(const SubStr, Value: String; From: integer): integer;
var
  ls,lv: integer;
begin
  Result := 0;
  ls := Length(SubStr);
  lv := Length(Value);
  if (ls = 0) or (lv = 0) then
    Exit;
  if From < 1 then
    From := 1;
  while (ls + from - 1) <= (lv) do
  begin
    {$IFNDEF CIL}
    if CompareMem(@SubStr[1],@Value[from],ls) then
    {$ELSE}
    if SubStr = copy(Value, from, ls) then
    {$ENDIF}
    begin
      result := from;
      break;
    end
    else
      inc(from);
  end;
end;

function getJsonFromJson(Data : String; Key: String) : String;
var
        StartPos : integer;
	EndPos : integer;
        val : String;
begin
	StartPos := Pos('"' + Key + '":',Data);

        if StartPos = 0 then
        begin
                Result := '{}';
        end
        else
        begin
                StartPos := StartPos  + Length('"' + Key + '":');
                if Copy(Data,StartPos,1) = '"' then StartPos := StartPos + 1;

                EndPos := PosFrom('}',Data,StartPos);
                if EndPos = 0 then Raise EPopbillException.Create(-99999999,'malformed json');

                if StartPos = EndPos then begin
                        Result := '{}';
                end
                else begin
                        val := Copy(Data,StartPos,EndPos-StartPos + 1);
                        result := val;
                end;
        end;
end;

constructor TStatementService.Create(LinkID : String; SecretKey : String);
begin
       inherited Create(LinkID,SecretKey);
       AddScope('121');
       AddScope('122');
       AddScope('123');
       AddScope('124');
       AddScope('125');
       AddScope('126');
end;

function TStatementService.GetURL(CorpNum : String; UserID : String; TOGO : String) : String;
var
        responseJson : String;
begin
        responseJson := httpget('/Statement/?TG='+ TOGO,CorpNum,UserID);
        result := getJSonString(responseJson,'url');
end;

function TStatementService.CheckMgtKeyInUse(CorpNum : String; ItemCode:Integer; MgtKey : String): boolean;
var
        responseJson : string;
        statementInfo : TStatementInfo;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;

        try                                                       
                responseJson := httpget('/Statement/'+ InttoStr(ItemCode) + '/'+MgtKey , CorpNum,'');
        except
                on E : EPopbillException do
                begin
                        if E.code = -12000004 then begin
                                result := false;
                                Exit;
                        end;
                        Raise E;
                end;
        end;
        statementInfo := jsonToTStatementInfo(responseJson);

        result:= statementInfo.ItemKey <> '';
end;

function TStatementService.TStatementTojson(Statement : TStatement; Memo : String) : String;
var
        requestJson : string;
        i : integer;
begin
       requestJson := '{';

        requestJson := requestJson + '"memo":"'+ Memo +'",';
        requestJson := requestJson + '"itemCode":"'+ EscapeString(IntToStr(Statement.ItemCode)) +'",';
        requestJson := requestJson + '"mgtKey":"'+ EscapeString(Statement.MgtKey) +'",';
        requestJson := requestJson + '"writeDate":"'+ EscapeString(Statement.WriteDate) +'",';
        requestJson := requestJson + '"formCode":"'+ EscapeString(Statement.FormCode) +'",';
        requestJson := requestJson + '"taxType":"'+ EscapeString(Statement.TaxType) +'",';

        requestJson := requestJson + '"senderCorpNum":"'+ EscapeString(Statement.SenderCorpNum) +'",';
        requestJson := requestJson + '"senderTaxRegID":"'+ EscapeString(Statement.SenderTaxRegID) +'",';
        requestJson := requestJson + '"senderCorpName":"'+ EscapeString(Statement.SenderCorpName) +'",';
        requestJson := requestJson + '"senderCEOName":"'+ EscapeString(Statement.SenderCEOName) +'",';
        requestJson := requestJson + '"senderAddr":"'+ EscapeString(Statement.SenderAddr) +'",';
        requestJson := requestJson + '"senderBizClass":"'+ EscapeString(Statement.SenderBizClass) +'",';
        requestJson := requestJson + '"senderBizType":"'+ EscapeString(Statement.SenderBizType) +'",';
        requestJson := requestJson + '"senderContactName":"'+ EscapeString(Statement.SenderContactName) +'",';
        requestJson := requestJson + '"senderDeptName":"'+ EscapeString(Statement.SenderDeptName) +'",';
        requestJson := requestJson + '"senderTEL":"'+ EscapeString(Statement.SenderTEL) +'",';
        requestJson := requestJson + '"senderHP":"'+ EscapeString(Statement.SenderHP) +'",';
        requestJson := requestJson + '"senderFAX":"'+ EscapeString(Statement.SenderFAX) +'",';
        requestJson := requestJson + '"senderEmail":"'+ EscapeString(Statement.SenderEmail) +'",';

        requestJson := requestJson + '"receiverCorpNum":"'+ EscapeString(Statement.ReceiverCorpNum) +'",';
        requestJson := requestJson + '"receiverTaxRegID":"'+ EscapeString(Statement.ReceiverTaxRegID) +'",';
        requestJson := requestJson + '"receiverCorpName":"'+ EscapeString(Statement.ReceiverCorpName) +'",';
        requestJson := requestJson + '"receiverCEOName":"'+ EscapeString(Statement.ReceiverCEOName) +'",';
        requestJson := requestJson + '"receiverAddr":"'+ EscapeString(Statement.ReceiverAddr) +'",';
        requestJson := requestJson + '"receiverBizType":"'+ EscapeString(Statement.ReceiverBizType) +'",';
        requestJson := requestJson + '"receiverBizClass":"'+ EscapeString(Statement.ReceiverBizClass) +'",';
        requestJson := requestJson + '"receiverContactName":"'+ EscapeString(Statement.ReceiverContactName) +'",';
        requestJson := requestJson + '"receiverDeptName":"'+ EscapeString(Statement.ReceiverDeptName) +'",';
        requestJson := requestJson + '"receiverTEL":"'+ EscapeString(Statement.ReceiverTEL) +'",';
        requestJson := requestJson + '"receiverHP":"'+ EscapeString(Statement.ReceiverHP) +'",';
        requestJson := requestJson + '"receiverFAX":"'+ EscapeString(Statement.ReceiverFAX) +'",';
        requestJson := requestJson + '"receiverEmail":"'+ EscapeString(Statement.ReceiverEmail) +'",';

        requestJson := requestJson + '"taxTotal":"'+ EscapeString(Statement.TaxTotal) +'",';
        requestJson := requestJson + '"supplyCostTotal":"'+ EscapeString(Statement.SupplyCostTotal) +'",';
        requestJson := requestJson + '"totalAmount":"'+ EscapeString(Statement.TotalAmount) +'",';

        requestJson := requestJson + '"purposeType":"'+ EscapeString(Statement.PurposeType) +'",';
        requestJson := requestJson + '"serialNum":"'+ EscapeString(Statement.SerialNum) +'",';

        if Statement.SMSSendYN then
        requestJson := requestJson + '"smssendYN":true,';

        if Statement.AutoAcceptYN then
        requestJson := requestJson + '"autoAcceptYN":true,';

        if Statement.BusinessLicenseYN then
        requestJson := requestJson + '"businessLicenseYN":true,';

        if Statement.BankBookYN then
        requestJson := requestJson + '"bankBookYN":true,';

        if Statement.FAXSendYN then
        requestJson := requestJson + '"faxsendYN":true,';


        if Length(Statement.detailList) > 0 then
        begin
                requestJson := requestJson + '"detailList":[';

                for i := 0 to Length(Statement.detailList)-1 do
                begin
                        requestJson := requestJson + '{';
                        requestJson := requestJson + '"serialNum":"' + IntToStr(Statement.detailList[i].SerialNum) + '",';
                        requestJson := requestJson + '"purchaseDT":"' + EscapeString(Statement.detailList[i].PurchaseDT) + '",';
                        requestJson := requestJson + '"itemName":"' +EscapeString(Statement.detailList[i].ItemName) + '",';
                        requestJson := requestJson + '"spec":"' + EscapeString(Statement.detailList[i].Spec) + '",';
                        requestJson := requestJson + '"unit":"' + EscapeString(Statement.detailList[i]._unit) + '",';
                        requestJson := requestJson + '"qty":"' + EscapeString(Statement.detailList[i].Qty) + '",';
                        requestJson := requestJson + '"unitCost":"' + EscapeString(Statement.detailList[i].UnitCost) + '",';
                        requestJson := requestJson + '"supplyCost":"' + EscapeString(Statement.detailList[i].SupplyCost) + '",';
                        requestJson := requestJson + '"tax":"' + EscapeString(Statement.detailList[i].Tax) + '",';
                        requestJson := requestJson + '"remark":"' + EscapeString(Statement.detailList[i].Remark) + '",';
                        requestJson := requestJson + '"spare1":"' + EscapeString(Statement.detailList[i].spare1) + '",';
                        requestJson := requestJson + '"spare2":"' + EscapeString(Statement.detailList[i].spare2) + '",';
                        requestJson := requestJson + '"spare3":"' + EscapeString(Statement.detailList[i].spare3) + '",';
                        requestJson := requestJson + '"spare4":"' + EscapeString(Statement.detailList[i].spare4) + '",';
                        requestJson := requestJson + '"spare5":"' + EscapeString(Statement.detailList[i].spare5) + '"';
                        requestJson := requestJson + '}';
                        if i < Length(Statement.detailList) - 1 then
                                 requestJson := requestJson + ',';

                end;

                requestJson := requestJson + '],';

        end;

        if Length(Statement.propertyBag) > 0 then
        begin
                requestJson := requestJson + '"propertyBag":{';

                for i := 0 to Length(Statement.propertyBag)-1 do
                begin
                        requestJson := requestJson + '"'+ EscapeString(Statement.propertyBag[i].name)+'":"' + EscapeString(Statement.propertyBag[i].value) + '"';

                        if i < Length(Statement.propertyBag) - 1 then
                                 requestJson := requestJson + ',';

                end;

                requestJson := requestJson + '},';

        end;


        requestJson := requestJson + '"remark1":"'+ EscapeString(Statement.Remark1) +'",';
        requestJson := requestJson + '"remark2":"'+ EscapeString(Statement.Remark2) +'",';
        requestJson := requestJson + '"remark3":"'+ EscapeString(Statement.Remark3) +'"';
        requestJson := requestJson + '}';

        result := requestJson;
end;


function TStatementService.RegistIssue(CorpNum : String; Statement : TStatement; Memo : String; UserID : String) : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        requestJson := TStatementTojson(Statement, Memo);

        responseJson := httppost('/Statement',CorpNum,UserID,requestJson,'ISSUE');

        result.code := getJSonInteger(responseJson,'code');
        result.message := getJSonString(responseJson,'message');
end;

function TStatementService.Register(CorpNum : String; Statement : TStatement; UserID : String) : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        requestJson := TStatementTojson(Statement,'');

        responseJson := httppost('/Statement',CorpNum,UserID,requestJson);

        result.code := getJSonInteger(responseJson,'code');
        result.message := getJSonString(responseJson,'message');

end;

function TStatementService.Update(CorpNum : String; ItemCode:Integer; MgtKey : String; Statement : TStatement; UserID : String) : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;
        
        requestJson := TStatementTojson(Statement,'');

        responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey,
                                CorpNum,UserID,requestJson,'PATCH');

        result.code := getJSonInteger(responseJson,'code');
        result.message := getJSonString(responseJson,'message');

end;

function TStatementService.Issue(CorpNum : String; ItemCode:Integer; MgtKey : String; Memo : String; UserID : String) : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;

        requestJson := '{"memo":"'+EscapeString(Memo)+'"}';

        responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey,
                                CorpNum,UserID,requestJson,'ISSUE');

        result.code := getJSonInteger(responseJson,'code');
        result.message := getJSonString(responseJson,'message');
end;

function TStatementService.Cancel(CorpNum : String; ItemCode:Integer; MgtKey : String; Memo : String; UserID : String) : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;
        requestJson := '{"memo":"'+EscapeString(Memo)+'"}';

        responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey,
                                CorpNum,UserID,requestJson,'CANCEL');

        result.code := getJSonInteger(responseJson,'code');
        result.message := getJSonString(responseJson,'message');
end;

function TStatementService.SendEmail(CorpNum : String; ItemCode:Integer; MgtKey :String; Receiver:String; UserID : String) : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;                                                             
        end;
        requestJson := '{"receiver":"'+EscapeString(Receiver)+'"}';

        responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey,
                                CorpNum,UserID,requestJson,'EMAIL');

        result.code := getJSonInteger(responseJson,'code');
        result.message := getJSonString(responseJson,'message');
end;

function TStatementService.SendSMS(CorpNum : String; ItemCode:Integer; MgtKey :String; Sender:String; Receiver:String; Contents : String; UserID : String) : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;
        requestJson := '{"sender":"'+EscapeString(Sender)+'","receiver":"'+EscapeString(Receiver)+'","contents":"'+EscapeString(Contents)+'"}';

        responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey,
                                CorpNum,UserID,requestJson,'SMS');

        result.code := getJSonInteger(responseJson,'code');
        result.message := getJSonString(responseJson,'message');
end;

function TStatementService.SendFAX(CorpNum : String; ItemCode:Integer; MgtKey :String; Sender:String; Receiver:String; UserID : String) : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;
        requestJson := '{"sender":"'+EscapeString(Sender)+'","receiver":"'+EscapeString(Receiver)+'"}';

        responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey,
                                CorpNum,UserID,requestJson,'FAX');

        result.code := getJSonInteger(responseJson,'code');
        result.message := getJSonString(responseJson,'message');
end;


function TStatementService.jsonToTStatementInfo(json : String) : TStatementInfo;
begin
        result := TStatementInfo.Create;

        result.ItemKey := getJSonString(json,'itemKey');
        result.InvoiceNum := getJSonString(json,'invoiceNum');
        result.MgtKey := getJSonString(json,'mgtKey');
        result.ItemCode := getJSonInteger(json,'itemCode');
        result.taxType := getJSonString(json,'taxType');
        result.writeDate := getJSonString(json,'writeDate');
        result.RegDT := getJSonString(json,'regDT');

        result.senderCorpName := getJSonString(json,'senderCorpName');
        result.senderCorpNum := getJSonString(json,'senderCorpNum');
        result.receiverCorpName := getJSonString(json,'receiverCorpName');
        result.receiverCorpNum := getJSonString(json,'receiverCorpNum');

        result.supplyCostTotal := getJSonString(json,'supplyCostTotal');
        result.taxTotal := getJSonString(json,'taxTotal');
        result.purposeType := getJSonString(json,'purposeType');

        result.issueDT := getJSonString(json,'issueDT');

        result.stateCode := getJSonInteger(json,'stateCode');
        result.stateDT := getJSonString(json,'stateDT');

        result.openYN := getJSonBoolean(json,'openYN');
        result.openDT := getJSonString(json,'openDT');

        result.stateMemo := getJSonString(json,'stateMemo');

end;

function TStatementService.getInfo(CorpNum : string; ItemCode:Integer; MgtKey: string) : TStatementInfo;
var
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;

        responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey , CorpNum,'');

        result := jsonToTStatementInfo(responseJson);

end;


function TStatementService.jsonToTStatement(json : String) : TStatement;
var
        jSons : ArrayOfString;
        i : Integer;
        tmp : String;
        tmpList : TStringList;
begin
        result := TStatement.Create;

        result.ItemCode                 := getJSonInteger(json,'itemCode');
        result.MgtKey                   := getJSonString(json,'mgtKey');
        result.InvoiceNum               := getJsonString(json,'invoiceNum');
        result.FormCode                 := getJsonString(json,'formCode');
        result.WriteDate                := getJSonString(json,'writeDate');

        result.TaxType                  := getJSonString(json,'taxType');

        result.senderCorpNum          := getJSonString(json,'senderCorpNum');
        result.senderTaxRegID         := getJSonString(json,'senderTaxRegID');
        result.senderCorpName         := getJSonString(json,'senderCorpName');
        result.senderCEOName          := getJSonString(json,'senderCEOName');
        result.senderAddr             := getJSonString(json,'senderAddr');
        result.senderBizClass         := getJSonString(json,'senderBizClass');
        result.senderBizType          := getJSonString(json,'senderBizType');
        result.senderContactName      := getJSonString(json,'senderContactName');
        result.senderDeptName         := getJSonString(json,'senderDeptName');
        result.senderTEL              := getJSonString(json,'senderTEL');
        result.senderHP               := getJSonString(json,'senderHP');
        result.senderFAX               := getJSonString(json,'senderFAX');
        result.senderEmail            := getJSonString(json,'senderEmail');

        result.receiverCorpNum          := getJSonString(json,'receiverCorpNum');
        result.receiverTaxRegID         := getJSonString(json,'receiverTaxRegID');
        result.receiverCorpName         := getJSonString(json,'receiverCorpName');
        result.receiverCEOName          := getJSonString(json,'receiverCEOName');
        result.receiverAddr             := getJSonString(json,'receiverAddr');
        result.receiverBizClass         := getJSonString(json,'receiverBizClass');
        result.receiverBizType          := getJSonString(json,'receiverBizType');
        result.receiverContactName      := getJSonString(json,'receiverContactName');
        result.receiverDeptName         := getJSonString(json,'receiverDeptName');
        result.receiverTEL              := getJSonString(json,'receiverTEL');
        result.receiverHP               := getJSonString(json,'receiverHP');
        result.receiverFAX               := getJSonString(json,'receiverFAX');
        result.receiverEmail            := getJSonString(json,'receiverEmail');

        result.taxTotal                := getJSonString(json,'taxTotal');
        result.supplyCostTotal         := getJSonString(json,'supplyCostTotal');
        result.totalAmount             := getJSonString(json,'totalAmount');

        result.purposeType             := getJSonString(json,'purposeType');
        result.serialNum               := getJSonString(json,'serialNum');

        result.remark1                 := getJSonString(json,'remark1');
        result.remark2                 := getJSonString(json,'remark2');
        result.remark3                 := getJSonString(json,'remark3');

        result.SMSSendYN                := getJSonBoolean(json,'smssendYN');
        result.AutoAcceptYN             := getJSonBoolean(json,'autoAcceptYN');
        result.businessLicenseYN        := getJSonBoolean(json,'businessLicenseYN');
        result.bankBookYN               := getJSonBoolean(json,'bankBookYN');
        result.fAXSendYN                := getJSonBoolean(json,'faxsendYN');

        //details.
        try
                jSons :=  getJSonList(json,'detailList');
                SetLength(result.detailList ,Length(jSons));

                for i := 0 to Length(jSons)-1 do
                begin
                        result.detailList[i] := TStatementDetail.Create;

                        result.detailList[i].SerialNum             := getJSonInteger(jSons[i],'serialNum');
                        result.detailList[i].purchaseDT            := getJSonString(jSons[i],'purchaseDT');
                        result.detailList[i].ItemName              := getJSonString(jSons[i],'itemName');
                        result.detailList[i].spec                  := getJSonString(jSons[i],'spec');
                        result.detailList[i]._unit                  := getJSonString(jSons[i],'unit');
                        result.detailList[i].qty                   := getJSonString(jSons[i],'qty');
                        result.detailList[i].unitCost              := getJSonString(jSons[i],'unitCost');
                        result.detailList[i].supplyCost            := getJSonString(jSons[i],'supplyCost');
                        result.detailList[i].tax                   := getJSonString(jSons[i],'tax');
                        result.detailList[i].remark                := getJSonString(jSons[i],'remark');

                        result.detailList[i].spare1                := getJSonString(jSons[i],'spare1');
                        result.detailList[i].spare2                := getJSonString(jSons[i],'spare2');
                        result.detailList[i].spare3                := getJSonString(jSons[i],'spare3');
                        result.detailList[i].spare4                := getJSonString(jSons[i],'spare4');
                        result.detailList[i].spare5                := getJSonString(jSons[i],'spare5');


                end;

        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;

        //propertyBag.
        try
                tmp :=  getJsonFromJson(json,'propertyBag');

                tmp := copy(tmp,3,length(tmp)-4);
                
                tmp := StringReplace(tmp,'":"','=',[rfReplaceAll]);
                tmp := StringReplace(tmp,'","',',',[rfReplaceAll]);
                
                tmpList := TStringList.Create;

                tmpList.CommaText := tmp;

                //Parse NameValue....
                SetLength(result.propertyBag , tmpList.Count);

                for i := 0 to tmpList.Count - 1 do
                begin
                        result.propertyBag[i] := TProperty.create;

                        result.propertyBag[i].name := tmpList.Names[i];
                        result.propertyBag[i].value :=  tmpList.Values[tmpList.Names[i]];

                        //ShowMessage(tmpList.Names[i] + ' : ' + tmpList.Values[tmpList.Names[i]]);

                end;

        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;

end;
function TStatementService.GetDetailInfo(CorpNum : string; ItemCode:Integer; MgtKey: string) : TStatement;
var
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;

        responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey + '?Detail' , CorpNum,'');

        result := jsonToTStatement(responseJson);

end;

function TStatementService.getLogs(CorpNum : string; ItemCode:Integer; MgtKey: string) : TStatementLogList;
var
        responseJson : string;
        jSons : ArrayOfString;
        i : Integer;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;

        responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey + '/Logs' ,
                                 CorpNum,
                                 '');

        try
                jSons := ParseJsonList(responseJson);
                SetLength(result,Length(jSons));

                for i := 0 to Length(jSons)-1 do
                begin
                        result[i] := TStatementLog.Create;

                        result[i].docLogType            := getJSonInteger(jSons[i],'docLogType');
                        result[i].Log                   := getJSonString(jSons[i],'log');
                        result[i].procType              := getJSonString(jSons[i],'procType');
                        result[i].procCorpName          := getJSonString(jSons[i],'procCorpName');
                        result[i].procContactName       := getJSonString(jSons[i],'procContactName');
                        result[i].procMemo              := getJSonString(jSons[i],'procMemo');
                        result[i].regDT                 := getJSonString(jSons[i],'regDT');
                        result[i].iP                    := getJSonString(jSons[i],'ip');
                end;

        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;
        
        
end;

function TStatementService.getInfos(CorpNum : string; ItemCode:Integer; MgtKeyList: Array Of String) : TStatementInfoList;
var
        requestJson : string;
        responseJson : string;
        jSons : ArrayOfString;
        i : Integer;
begin
        if Length(MgtKeyList) = 0 then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;

        requestJson := '[';
        for i:=0 to Length(MgtKeyList) -1 do
        begin
                requestJson := requestJson + '"' + MgtKeyList[i] + '"';
                if (i + 1) < Length(MgtKeyList) then requestJson := requestJson + ',';
        end;

        requestJson := requestJson + ']';

        responseJson := httppost('/Statement/'+ IntToStr(ItemCode),CorpNum,'',requestJson);

        try
                jSons := ParseJsonList(responseJson);
                SetLength(result,Length(jSons));

                for i := 0 to Length(jSons)-1 do
                begin
                        result[i] := jsonToTStatementInfo(jSons[i]);
                end;

        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;
        
end;


function TStatementService.Delete(CorpNum : String; ItemCode:Integer;  MgtKey: String; UserID : String) : TResponse;
var
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;
        responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey,CorpNum,UserID,'','DELETE');

        result.code := getJSonInteger(responseJson,'code');
        result.message := getJSonString(responseJson,'message');
end;

function TStatementService.AttachFile(CorpNum : String; ItemCode:Integer; MgtKey : String; FilePath : String; UserID : String) : TResponse;
var
        responseJson : string;
        fileName : string;
        fileData : TFileStream;
begin

       if MgtKey = '' then
       begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
       end;

       fileName := ExtractFileName(FilePath);
       fileData := TFileStream.Create(FilePath,fmOpenRead);

       try
                responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey + '/Files',CorpNum,UserID,'Filedata',fileName,fileData);
       finally
        fileData.Free;
       end;
       result.code := getJSonInteger(responseJson,'code');
       result.message := getJSonString(responseJson,'message');

end;

function TStatementService.GetFiles(CorpNum: String; ItemCode:Integer; MgtKey : String) : TAttachedFileList;
var
        responseJson : string;
        jSons : ArrayOfString;
        i : integer;
begin
        responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey + '/Files',CorpNum,'');

        try
                jSons := ParseJsonList(responseJson);
                SetLength(result,Length(jSons));

                for i := 0 to Length(jSons)-1 do
                begin
                        result[i] := TAttachedFile.Create;

                        result[i].SerialNum :=  getJSonInteger(jSons[i],'serialNum');
                        result[i].AttachedFile := getJSonString(jSons[i],'attachedFile');
                        result[i].DisplayName := getJSonString(jSons[i],'displayName');
                        result[i].RegDT := getJSonString(jSons[i],'regDT');

                end;

        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;
end;

function TStatementService.DeleteFile(CorpNum : String; ItemCode:Integer;  MgtKey: String; FileID : String; UserID : String) : TResponse;
var
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;

        if FileID = '' then
        begin
                raise EPopbillException.Create(-99999999,'파일 아이디가 입력되지 않았습니다.');
                Exit;
        end;

        responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey + '/Files/' + FileID,CorpNum,UserID,'','DELETE');

        result.code := getJSonInteger(responseJson,'code');
        result.message := getJSonString(responseJson,'message');
end;

function TStatementService.GetPopUpURL(CorpNum: string; ItemCode:Integer; MgtKey : String;UserID : String) : string;
var
        responseJson : String;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;
        
        responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey +'?TG=POPUP',CorpNum,UserID);

        result := getJSonString(responseJson,'url');
end;

function TStatementService.GetPrintURL(CorpNum: string; ItemCode:Integer; MgtKey : String;UserID : String) : string;
var
        responseJson : String;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;
        
        responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey +'?TG=PRINT',CorpNum,UserID);

        result := getJSonString(responseJson,'url');
end;

function TStatementService.GetEPrintURL(CorpNum: string; ItemCode:Integer; MgtKey : String;UserID : String) : string;
var
        responseJson : String;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;
        
        responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey +'?TG=EPRINT',CorpNum,UserID);

        result := getJSonString(responseJson,'url');
end;

function TStatementService.GetMassPrintURL(CorpNum: string; ItemCode:Integer; MgtKeyList: Array Of String; UserID: String) : string;
var
        requestJson,responseJson:string;
        i : integer;
begin
        if Length(MgtKeyList) = 0 then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;

        requestJson := '[';
        for i:=0 to Length(MgtKeyList) -1 do
        begin
                requestJson := requestJson + '"' + EscapeString(MgtKeyList[i]) + '"';
                if (i + 1) < Length(MgtKeyList) then requestJson := requestJson + ',';
        end;

        requestJson := requestJson + ']';

        responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '?Print',
                                CorpNum,
                                UserID,
                                requestJson);

        result := getJSonString(responseJson,'url');

end;

function TStatementService.GetMailURL(CorpNum: string; ItemCode:Integer; MgtKey : String;UserID : String) : string;
var
        responseJson : String;
begin
        if MgtKey = '' then
        begin
                raise EPopbillException.Create(-99999999,'관리번호가 입력되지 않았습니다.');
                Exit;
        end;
        
        responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey +'?TG=MAIL',CorpNum,UserID);

        result := getJSonString(responseJson,'url');
end;


function TStatementService.GetUnitCost(CorpNum : String;ItemCode:Integer) : Single;
var
        responseJson : string;
begin
        responseJson := httpget('/Statement/'+IntToStr(ItemCode)+'?cfg=UNITCOST',CorpNum,'');

        result := strToFloat(getJSonString( responseJson,'unitCost'));

end;

//End Of Unit.
end.
