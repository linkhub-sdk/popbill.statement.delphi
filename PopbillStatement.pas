(*
*=================================================================================
* Unit for base module for Popbill API SDK. It include base functionality for
* RESTful web service request and parse json result. It uses Linkhub module
* to accomplish authentication APIs.
*
* For strongly secured communications, this module uses SSL/TLS with OpenSSL.
*
* http://www.popbill.com
* Author : Kim Seongjun (pallet027@gmail.com)
* Written : 2014-07-17
* Contributor : Jeong Yohan(code@linkhub.co.kr)
* Updated : 2021-06-15
*
* Thanks for your interest.
*=================================================================================
*)
unit PopbillStatement;

interface

uses
        TypInfo,SysUtils,Classes,
        Popbill,
        Linkhub;
type

        TSMTIssueResponse = Record
                code : LongInt;
                message : string;
                invoiceNum : string;
        end;
        
        TStatementChargeInfo = class
        public
                unitCost : string;
                chargeMethod : string;
                rateSystem : string;
        end;

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
                spare6         : string;
                spare7         : string;
                spare8         : string;
                spare9         : string;
                spare10        : string;
                spare11        : string;
                spare12        : string;
                spare13        : string;
                spare14        : string;
                spare15        : string;
                spare16        : string;
                spare17        : string;
                spare18        : string;
                spare19        : string;
                spare20        : string;
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
                emailSubject         : string;

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
                destructor Destroy; override;
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
                SenderPrintYN           : Boolean;
                ReceiverCorpName        : string;
                ReceiverCorpNum         : string;
                ReceiverPrintYN         : Boolean;

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

        TStatementSearchList = class
        public
                code                    : Integer;
                total                   : Integer;
                perPage                 : Integer;
                pageNum                 : Integer;
                pageCount               : Integer;
                message                 : String;
                list                    : TStatementInfoList;
                destructor Destroy; override;
        end;

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

        TEmailConfig = class
        public
                EmailType : String;
                SendYN    : Boolean;
        end;

        TEmailConfigList = Array of TEmailConfig;

        TStatementService = class(TPopbillBaseService)
        private                                  
                
                function jsonToTStatementInfo(json : String) : TStatementInfo;
                function jsonToTStatement(json : String) : TStatement;
                function TStatementTojson(Statement : TStatement; Memo : String; sendNum : String; receiveNum: String) : String;
                
        public
                constructor Create(LinkID : String; SecretKey : String);
                
                //팝필 거래명세서 연결 url.
                function GetURL(CorpNum : String; UserID : String; TOGO : String) : String; overload;

                //팝필 거래명세서 연결 url.
                function GetURL(CorpNum : String; TOGO : String) : String; overload;

                //팝빌 인감 및 첨부문서 등록 URL
                function GetSealURL(CorpNum : String; UserID : String) : String;

                //문서번호 사용여부 확인
                function CheckMgtKeyInUse(CorpNum : String; ItemCode:Integer; MgtKey : String) : boolean;

                //즉시발행 
                function RegistIssue(CorpNum : String; Statement : TStatement; Memo : String; UserID : String = ''; EmailSubject : String = '') : TSMTIssueResponse;

                //임시저장.
                function Register(CorpNum : String; Statement : TStatement; UserID : String = '') : TResponse;
                
                //수정.
                function Update(CorpNum : String; ItemCode:Integer; MgtKey : String; Statement : TStatement; UserID : String = '') : TResponse;

                //발행.
                function Issue(CorpNum : String; ItemCode:Integer; MgtKey : String; Memo :String; UserID : String = '') : TResponse;
                
                //취소.
                function Cancel(CorpNum : String; ItemCode:Integer; MgtKey : String; Memo : String; UserID : String = '') : TResponse;
                
                //삭제.
                function Delete(CorpNum : String; ItemCode:Integer;  MgtKey: String; UserID : String = '') : TResponse;
                

                //이메일재전송.
                function SendEmail(CorpNum : String; ItemCode:Integer; MgtKey : String; Receiver:String; UserID : String = '') : TResponse;

                //문자재전송.
                function SendSMS(CorpNum : String; ItemCode:Integer; MgtKey :String; Sender:String; Receiver:String; Contents : String; UserID : String = '') : TResponse;

                // 팩스 재전송.
                function SendFAX(CorpNum : String; ItemCode:Integer; MgtKey :String; Sender:String; Receiver:String; UserID : String = '') : TResponse;

                // 팩스 사전 전송
                function FAXSend(CorpNum : String; Statement : TStatement; sendNum : String; receiveNum : String; UserID : String = '') : String;

                // 전자명세서 목록조회
                function Search(CorpNum : String; DType:String; SDate:String; EDate:String; State:Array Of String; ItemCode:Array Of Integer; Page:Integer; PerPage: Integer; Order : String) : TStatementSearchList; overload;
                
                // 전자명세서 목록조회
                function Search(CorpNum : String; DType:String; SDate:String; EDate:String; State:Array Of String; ItemCode:Array Of Integer; QString:String; Page:Integer; PerPage: Integer; Order : String) : TStatementSearchList; overload;


                //전자명세서 요약정보 및 상태정보 확인.
                function GetInfo(CorpNum : string; ItemCode:Integer; MgtKey: string) : TStatementInfo;
                
                //전자명세서 상세정보 확인
                function GetDetailInfo(CorpNum : string; ItemCode:Integer; MgtKey: string) : TStatement;

                //전자명세서 요약정보 및 상태 다량 확인.
                function GetInfos(CorpNum : string; ItemCode:Integer; MgtKeyList: Array Of String) : TStatementInfoList;

                //문서이력 확인.
                function GetLogs(CorpNum : string; ItemCode:Integer; MgtKey: string) : TStatementLogList;

                //파일 첨부.
                function AttachFile(CorpNum : String; ItemCode:Integer; MgtKey : String; FilePath : String; UserID : String = '') : TResponse;

                //첨부파일 목록 확인.
                function GetFiles(CorpNum: String; ItemCode:Integer; MgtKey : String) : TAttachedFileList;

                //첨부파일 삭제.
                function DeleteFile(CorpNum: string; ItemCode:Integer; MgtKey : String; FileID : String; UserID : String = '') : TResponse;


                //팝업URL
                function GetPopUpURL(CorpNum: string; ItemCode:Integer; MgtKey : String; UserID: String = '') : string;

                //인쇄URL
                function GetPrintURL(CorpNum: string; ItemCode:Integer; MgtKey : String; UserID: String = '') : string;

                function GetViewURL(CorpNum: string; ItemCode:Integer; MgtKey : String; UserID: String = '') : string;

                //수신자인쇄URL
                function GetEPrintURL(CorpNum: string; ItemCode:Integer; MgtKey : String; UserID: String = '') : string;

                //다량인쇄URL
                function GetMassPrintURL(CorpNum: string; ItemCode:Integer; MgtKeyList: Array Of String; UserID: String = '') : string;

                //Mail URL
                function GetMailURL(CorpNum: string; ItemCode:Integer; MgtKey : String; UserID: String = '') : string;


                //회원별 전자명세서 발행단가 확인.
                function GetUnitCost(CorpNum : String; ItemCode:Integer) : Single;

                // 다른 전자명세서 첨부
                function AttachStatement(CorpNum : String; ItemCode:Integer; MgtKey:String; SubItemCode :Integer; SubMgtKey :String) : TResponse;

                // 다른 전자명세서 해제
                function DetachStatement(CorpNum : String; ItemCode:Integer; MgtKey:String; SubItemCode :Integer; SubMgtKey :String) : TResponse;

                // 과금정보 확인
                function GetChargeInfo(CorpNum : String; ItemCode:Integer) : TStatementChargeInfo;

                // 알림메일 전송목록 조회
                function ListEmailConfig(CorpNum : String; UserID : String = '') : TEmailConfigList;

                // 알림메일 전송설정 수정
                function UpdateEmailConfig(CorpNum : String; EmailType : String; SendYN : Boolean; UserID : String = '') : TResponse;
        end;


implementation

destructor TStatement.Destroy;
var
  i: Integer;
begin
  for i := 0 to Length(detailList)-1 do
    if Assigned(detailList[i]) then
      detailList[i].Free;
  SetLength(detailList, 0);
  for i := 0 to Length(propertyBag)-1 do
    if Assigned(propertyBag[i]) then
      propertyBag[i].Free;
  SetLength(propertyBag, 0);
  inherited Destroy;
end;

destructor TStatementSearchList.Destroy;
var
  i: Integer;
begin
  for i := 0 to Length(list)-1 do
    if Assigned(list[i]) then
      list[i].Free;
  SetLength(list, 0);
  inherited Destroy;
end;

function UrlEncodeUTF8(stInput : widestring) : string;
  const
    hex : array[0..255] of string = (
     '%00', '%01', '%02', '%03', '%04', '%05', '%06', '%07',
     '%08', '%09', '%0a', '%0b', '%0c', '%0d', '%0e', '%0f',
     '%10', '%11', '%12', '%13', '%14', '%15', '%16', '%17',
     '%18', '%19', '%1a', '%1b', '%1c', '%1d', '%1e', '%1f',
     '%20', '%21', '%22', '%23', '%24', '%25', '%26', '%27',
     '%28', '%29', '%2a', '%2b', '%2c', '%2d', '%2e', '%2f',
     '%30', '%31', '%32', '%33', '%34', '%35', '%36', '%37',
     '%38', '%39', '%3a', '%3b', '%3c', '%3d', '%3e', '%3f',
     '%40', '%41', '%42', '%43', '%44', '%45', '%46', '%47',
     '%48', '%49', '%4a', '%4b', '%4c', '%4d', '%4e', '%4f',
     '%50', '%51', '%52', '%53', '%54', '%55', '%56', '%57',
     '%58', '%59', '%5a', '%5b', '%5c', '%5d', '%5e', '%5f',
     '%60', '%61', '%62', '%63', '%64', '%65', '%66', '%67',
     '%68', '%69', '%6a', '%6b', '%6c', '%6d', '%6e', '%6f',
     '%70', '%71', '%72', '%73', '%74', '%75', '%76', '%77',
     '%78', '%79', '%7a', '%7b', '%7c', '%7d', '%7e', '%7f',
     '%80', '%81', '%82', '%83', '%84', '%85', '%86', '%87',
     '%88', '%89', '%8a', '%8b', '%8c', '%8d', '%8e', '%8f',
     '%90', '%91', '%92', '%93', '%94', '%95', '%96', '%97',
     '%98', '%99', '%9a', '%9b', '%9c', '%9d', '%9e', '%9f',
     '%a0', '%a1', '%a2', '%a3', '%a4', '%a5', '%a6', '%a7',
     '%a8', '%a9', '%aa', '%ab', '%ac', '%ad', '%ae', '%af',
     '%b0', '%b1', '%b2', '%b3', '%b4', '%b5', '%b6', '%b7',
     '%b8', '%b9', '%ba', '%bb', '%bc', '%bd', '%be', '%bf',
     '%c0', '%c1', '%c2', '%c3', '%c4', '%c5', '%c6', '%c7',
     '%c8', '%c9', '%ca', '%cb', '%cc', '%cd', '%ce', '%cf',
     '%d0', '%d1', '%d2', '%d3', '%d4', '%d5', '%d6', '%d7',
     '%d8', '%d9', '%da', '%db', '%dc', '%dd', '%de', '%df',
     '%e0', '%e1', '%e2', '%e3', '%e4', '%e5', '%e6', '%e7',
     '%e8', '%e9', '%ea', '%eb', '%ec', '%ed', '%ee', '%ef',
     '%f0', '%f1', '%f2', '%f3', '%f4', '%f5', '%f6', '%f7',
     '%f8', '%f9', '%fa', '%fb', '%fc', '%fd', '%fe', '%ff');
 var
   iLen,iIndex : integer;
   stEncoded : string;
   ch : widechar;
 begin
   iLen := Length(stInput);
   stEncoded := '';
   for iIndex := 1 to iLen do
   begin
     ch := stInput[iIndex];
     if (ch >= 'A') and (ch <= 'Z') then
       stEncoded := stEncoded + ch
     else if (ch >= 'a') and (ch <= 'z') then
       stEncoded := stEncoded + ch
     else if (ch >= '0') and (ch <= '9') then
       stEncoded := stEncoded + ch
     else if (ch = ' ') then
       stEncoded := stEncoded + '+'
     else if ((ch = '-') or (ch = '_') or (ch = '.') or (ch = '!') or (ch = '*')
       or (ch = '~') or (ch = '\')  or (ch = '(') or (ch = ')')) then
       stEncoded := stEncoded + ch
     else if (Ord(ch) <= $07F) then
       stEncoded := stEncoded + hex[Ord(ch)]
     else if (Ord(ch) <= $7FF) then
     begin
        stEncoded := stEncoded + hex[$c0 or (Ord(ch) shr 6)];
        stEncoded := stEncoded + hex[$80 or (Ord(ch) and $3F)];
     end
     else
     begin
        stEncoded := stEncoded + hex[$e0 or (Ord(ch) shr 12)];
        stEncoded := stEncoded + hex[$80 or ((Ord(ch) shr 6) and ($3F))];
        stEncoded := stEncoded + hex[$80 or ((Ord(ch)) and ($3F))];
     end;
   end;
   result := (stEncoded);
 end;


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

                EndPos :=skiptoSquareBracket(Data,StartPos);
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

function TStatementService.GetChargeInfo(CorpNum : string; ItemCode:Integer) : TStatementChargeInfo;
var
        responseJson : String;
begin
        try
                responseJson := httpget('/Statement/ChargeInfo/'+IntToStr(ItemCode),CorpNum,'');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                        end;
                end;
        end;

        try
                result := TStatementChargeInfo.Create;

                result.unitCost := getJSonString(responseJson, 'unitCost');
                result.chargeMethod := getJSonString(responseJson, 'chargeMethod');
                result.rateSystem := getJSonString(responseJson, 'rateSystem');

        except on E:Exception do
                begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
                                exit;
                        end
                        else
                        begin
                                result := TStatementChargeInfo.Create;
                                setLastErrCode(-99999999);
                                setLastErrMessage('결과처리 실패.[Malformed Json]');
                                exit;
                        end;
                end;
        end;
end;

function TStatementService.GetURL(CorpNum : String; TOGO : String) : String;
begin
        result := GetURL(CorpNum, '', TOGO);
end;

function TStatementService.GetURL(CorpNum : String; UserID : String; TOGO : String) : String;
var
        responseJson : String;
begin
        try
                responseJson := httpget('/Statement/?TG='+ TOGO,CorpNum,UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end
                        else
                        begin
                                result := '';
                                exit;
                        end;
                end;
        end;
end;

function TStatementService.GetSealURL(CorpNum : String; UserID : String) : String;
var
        responseJson : String;
begin
        try        
                responseJson := httpget('/?TG=SEAL', CorpNum, UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end
                        else
                        begin
                                result := '';
                                exit;
                        end;
                end;
        end;       
end;

function TStatementService.CheckMgtKeyInUse(CorpNum : String; ItemCode:Integer; MgtKey : String): boolean;
var
        responseJson : string;
        statementInfo : TStatementInfo;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result := false;
                        setLastErrCode(-99999999);
                        setLastErrMessage('문서번호가 입력되지 않았습니다.');
                        exit;
                end;
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
                        raise EPopbillException.Create(E.code, E.message);
                end;
        end;
        statementInfo := jsonToTStatementInfo(responseJson);

        result:= statementInfo.ItemKey <> '';
end;

function TStatementService.TStatementTojson(Statement : TStatement; Memo : String; sendNum : String; receiveNum :String) : String;
var
        requestJson : string;
        i : integer;
begin
        requestJson := '{';

        if sendNum <> '' then
        requestJson := requestJson + '"sendNum":"'+sendNum+'",';

        if receiveNum <> '' then
        requestJson := requestJson + '"receiveNum":"'+receiveNum+'",';

        if EscapeString(Statement.EmailSubject) <> '' then
        requestJson := requestJson + '"emailSubject":"'+EscapeString(Statement.EmailSubject) +'",';
        
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
                        requestJson := requestJson + '"spare5":"' + EscapeString(Statement.detailList[i].spare5) + '",';
                        requestJson := requestJson + '"spare6":"' + EscapeString(Statement.detailList[i].spare6) + '",';
                        requestJson := requestJson + '"spare7":"' + EscapeString(Statement.detailList[i].spare7) + '",';
                        requestJson := requestJson + '"spare8":"' + EscapeString(Statement.detailList[i].spare8) + '",';
                        requestJson := requestJson + '"spare9":"' + EscapeString(Statement.detailList[i].spare9) + '",';
                        requestJson := requestJson + '"spare10":"' + EscapeString(Statement.detailList[i].spare10) + '",';
                        requestJson := requestJson + '"spare11":"' + EscapeString(Statement.detailList[i].spare11) + '",';
                        requestJson := requestJson + '"spare12":"' + EscapeString(Statement.detailList[i].spare12) + '",';
                        requestJson := requestJson + '"spare13":"' + EscapeString(Statement.detailList[i].spare13) + '",';
                        requestJson := requestJson + '"spare14":"' + EscapeString(Statement.detailList[i].spare14) + '",';
                        requestJson := requestJson + '"spare15":"' + EscapeString(Statement.detailList[i].spare15) + '",';
                        requestJson := requestJson + '"spare16":"' + EscapeString(Statement.detailList[i].spare16) + '",';
                        requestJson := requestJson + '"spare17":"' + EscapeString(Statement.detailList[i].spare17) + '",';
                        requestJson := requestJson + '"spare18":"' + EscapeString(Statement.detailList[i].spare18) + '",';
                        requestJson := requestJson + '"spare19":"' + EscapeString(Statement.detailList[i].spare19) + '",';
                        requestJson := requestJson + '"spare20":"' + EscapeString(Statement.detailList[i].spare20) + '"';

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

function TStatementService.FAXSend(CorpNum : String; Statement : TStatement; sendNum:String; receiveNum: String; UserID : String = '') : String;
var
        requestJson : string;
        responseJson : string;
begin

        try
                requestJson := TStatementTojson(Statement,'',sendNum,receiveNum);
                responseJson := httppost('/Statement',CorpNum,UserID,requestJson,'FAX');
                result := getJSonString(responseJson,'receiptNum');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end;
                end;
        end;
end;

function TStatementService.RegistIssue(CorpNum : String; Statement : TStatement; Memo : String; UserID : String = ''; EmailSubject : String = '') : TSMTIssueResponse;
var
        requestJson : string;
        responseJson : string;
begin
        try
                if EmailSubject <> '' then
                begin
                        Statement.emailSubject := EmailSubject;
                end;

                requestJson := TStatementTojson(Statement, Memo,'','');
                responseJson := httppost('/Statement',CorpNum,UserID,requestJson,'ISSUE');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
                result.invoiceNum := getJSonString(responseJson,'invoiceNum');
        end;
end;

function TStatementService.Register(CorpNum : String; Statement : TStatement; UserID : String) : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        try
                requestJson := TStatementTojson(Statement,'','','');
                responseJson := httppost('/Statement',CorpNum,UserID,requestJson);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;
end;

function TStatementService.Update(CorpNum : String; ItemCode:Integer; MgtKey : String; Statement : TStatement; UserID : String) : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '문서번호가 입력되지 않았습니다.';
                        Exit;
                end;
        end;
        
        try
                requestJson := TStatementTojson(Statement,'','','');

                responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey,
                                        CorpNum,UserID,requestJson,'PATCH');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;
end;

function TStatementService.Issue(CorpNum : String; ItemCode:Integer; MgtKey : String; Memo : String; UserID : String) : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '문서번호가 입력되지 않았습니다.';
                        Exit;
                end;
        end;

        try
                requestJson := '{"memo":"'+EscapeString(Memo)+'"}';

                responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey,
                                        CorpNum,UserID,requestJson,'ISSUE');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;

end;

function TStatementService.Cancel(CorpNum : String; ItemCode:Integer; MgtKey : String; Memo : String; UserID : String) : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '문서번호가 입력되지 않았습니다.';
                        Exit;
                end;
        end;

        try
                requestJson := '{"memo":"'+EscapeString(Memo)+'"}';
                responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey,
                                        CorpNum,UserID,requestJson,'CANCEL');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;
end;

function TStatementService.SendEmail(CorpNum : String; ItemCode:Integer; MgtKey :String; Receiver:String; UserID : String = '') : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '문서번호가 입력되지 않았습니다.';
                        Exit;
                end;
        end;
        
        try
                requestJson := '{"receiver":"'+EscapeString(Receiver)+'"}';

                responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey,
                                        CorpNum,UserID,requestJson,'EMAIL');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;
end;

function TStatementService.SendSMS(CorpNum : String; ItemCode:Integer; MgtKey :String; Sender:String; Receiver:String; Contents : String; UserID : String = '') : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '문서번호가 입력되지 않았습니다.';
                        Exit;
                end;
        end;
        
        try
                requestJson := '{"sender":"'+EscapeString(Sender)+'","receiver":"'+EscapeString(Receiver)+'","contents":"'+EscapeString(Contents)+'"}';

                responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey,
                                        CorpNum,UserID,requestJson,'SMS');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;

end;

function TStatementService.SendFAX(CorpNum : String; ItemCode:Integer; MgtKey :String; Sender:String; Receiver:String; UserID : String = '') : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '문서번호가 입력되지 않았습니다.';
                        Exit;
                end;
        end;

        try
                requestJson := '{"sender":"'+EscapeString(Sender)+'","receiver":"'+EscapeString(Receiver)+'"}';

                responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey,
                                        CorpNum,UserID,requestJson,'FAX');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;
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
        result.senderPrintYN := getJSonBoolean(json,'senderPrintYN');

        result.receiverCorpName := getJSonString(json,'receiverCorpName');
        result.receiverCorpNum := getJSonString(json,'receiverCorpNum');
        result.receiverPrintYN := getJSonBoolean(json,'receiverPrintYN');
        
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
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result := TStatementInfo.Create;
                        setLastErrCode(-99999999);
                        setLastErrMessage('문서번호가 입력되지 않았습니다.');
                        exit;
                end;
        end;

        try
                responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey , CorpNum,'');
                result := jsonToTStatementInfo(responseJson);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.Message);
                                exit;
                        end
                        else
                        begin
                                result := TStatementInfo.Create;
                                exit;
                        end;
                end;
        end;

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
                        result.detailList[i].spare6                := getJSonString(jSons[i],'spare6');
                        result.detailList[i].spare7                := getJSonString(jSons[i],'spare7');
                        result.detailList[i].spare8                := getJSonString(jSons[i],'spare8');
                        result.detailList[i].spare9                := getJSonString(jSons[i],'spare9');
                        result.detailList[i].spare10                := getJSonString(jSons[i],'spare10');
                        result.detailList[i].spare11                := getJSonString(jSons[i],'spare11');
                        result.detailList[i].spare12                := getJSonString(jSons[i],'spare12');
                        result.detailList[i].spare13                := getJSonString(jSons[i],'spare13');
                        result.detailList[i].spare14                := getJSonString(jSons[i],'spare14');
                        result.detailList[i].spare15                := getJSonString(jSons[i],'spare15');
                        result.detailList[i].spare16                := getJSonString(jSons[i],'spare16');
                        result.detailList[i].spare17                := getJSonString(jSons[i],'spare17');
                        result.detailList[i].spare18                := getJSonString(jSons[i],'spare18');
                        result.detailList[i].spare19                := getJSonString(jSons[i],'spare19');
                        result.detailList[i].spare20                := getJSonString(jSons[i],'spare20');
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
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result := TStatement.Create;
                        setLastErrCode(-99999999);
                        setLastErrMessage('문서번호가 입력되지 않았습니다.');
                        exit;
                end;

        end;

        try
                responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey + '?Detail' , CorpNum,'');
                result := jsonToTStatement(responseJson);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end
                        else
                        begin
                                result := TStatement.Create();
                                exit;
                        end;
                end;
        end;
end;

function TStatementService.getLogs(CorpNum : string; ItemCode:Integer; MgtKey: string) : TStatementLogList;
var
        responseJson : string;
        jSons : ArrayOfString;
        i : Integer;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        SetLength(result,0);
                        setLastErrCode(-99999999);
                        setLastErrMessage('문서번호가 입력되지 않았습니다.');
                        Exit;
                end;

        end;

        try
                responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey + '/Logs', CorpNum,'');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                        end
                        else
                        begin
                                SetLength(result,0);
                                SetLength(jSons,0);
                                exit;
                        end;
                end;

        end;


        if LastErrCode <> 0 then
        begin
                exit;
        end
        else
        begin        
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
                except on E:Exception do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
                                exit;
                        end
                        else
                        begin
                                SetLength(result,0);
                                SetLength(jSons,0);
                                setLastErrCode(-99999999);
                                setLastErrMessage('결과처리 실패.[Malformed Json]');
                                exit;
                        end;
                end;
        end;
        end;
        

end;

function TStatementService.Search(CorpNum : String; DType:String; SDate:String; EDate:String; State:Array Of String; ItemCode:Array Of Integer; Page:Integer; PerPage: Integer; Order : String) : TStatementSearchList;
begin
        result := Search(CorpNum, DType, SDate, EDate, State, ItemCode, '', Page, PerPage, Order);
end;

function TStatementService.Search(CorpNum : String; DType:String; SDate:String; EDate:String; State:Array Of String; ItemCode:Array Of Integer; QString:String; Page:Integer; PerPage: Integer; Order : String) : TStatementSearchList;
var
        responseJson : String;
        uri : String;
        StateList : String;
        ItemCodeList : String;
        i : integer;
        jSons : ArrayOfString;

begin

        for i := 0 to High(State) do
        begin
                if State[i] <> '' Then
                begin
                        if i = High(State) Then
                        begin
                                StateList := StateList + State[i];
                        end
                        else begin
                                StateList := StateList + State[i] +',';
                        end;
                end
        end;

        for i := 0 to High(ItemCode) do
        begin
                if ItemCode[i] > 0 Then
                begin
                        if i = High(ItemCode) Then
                        begin
                                ItemCodeList := ItemCodeList + IntToStr(ItemCode[i]);
                        end
                        else begin
                                ItemCodeList := ItemCodeList + IntToStr(ItemCode[i]) +',';
                        end;
                end
        end;

        uri := '/Statement/Search?DType='+DType+'&&SDate='+SDate+'&&EDate='+EDate;
        uri := uri + '&&State='+StateList + '&&ItemCode='+ItemCodeList;
        uri := uri + '&&Page='+IntToStr(Page)+'&&PerPage='+IntToStr(PerPage);
        uri := uri + '&&Order=' + Order;
        uri := uri + '&&QString=' + UrlEncodeUTF8(QString);


        try
                responseJson := httpget(uri, CorpNum,'');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end
                        else
                        begin
                                result := TStatementSearchList.Create;
                                result.code := le.code;
                                result.message := le.message;
                                exit;
                        end;
                end;

        end;

        if LastErrCode <> 0 then
        begin
                result := TStatementSearchList.Create;
                result.code := LastErrCode;
                result.message := LastErrMessage;
                exit;
        end
        else
        begin
        
                result := TStatementSearchList.Create;

                result.code             := getJSonInteger(responseJson,'code');
                result.total            := getJSonInteger(responseJson,'total');
                result.perPage          := getJSonInteger(responseJson,'perPage');
                result.pageNum          := getJSonInteger(responseJson,'pageNum');
                result.pageCount        := getJSonInteger(responseJson,'pageCount');
                result.message          := getJSonString(responseJson,'message');

                try

                        jSons := getJSonList(responseJson,'list');
                        SetLength(result.list, Length(jSons));
                        for i:=0 to Length(jSons)-1 do
                        begin
                                result.list[i] := jsonToTStatementInfo(jSons[i]);
                        end;
                except on E:Exception do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
                                exit;
                        end
                        else
                        begin
                                result := TStatementSearchList.Create;
                                result.code := -99999999;
                                result.message := '결과처리 실패.[Malformed Json]';
                                exit; 
                        end;
                end;
        end;
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
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        SetLength(result, 0);
                        setLastErrCode(-99999999);
                        setLastErrMessage('문서번호가 입력되지 않았습니다.');
                        exit;
                end;
        end;

        requestJson := '[';
        for i:=0 to Length(MgtKeyList) -1 do
        begin
                requestJson := requestJson + '"' + MgtKeyList[i] + '"';
                if (i + 1) < Length(MgtKeyList) then requestJson := requestJson + ',';
        end;

        requestJson := requestJson + ']';

        try
                responseJson := httppost('/Statement/'+ IntToStr(ItemCode),CorpNum,'',requestJson);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                        end
                        else
                        begin
                                SetLength(result, 0);
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                SetLength(result,0);
                SetLength(jSons,0);
                setLastErrCode(LastErrCode);
                setLastErrMessage(LastErrMessage);
                exit;
        end
        else
        begin
                try
                        jSons := ParseJsonList(responseJson);
                        SetLength(result,Length(jSons));

                        for i := 0 to Length(jSons)-1 do
                        begin
                                result[i] := jsonToTStatementInfo(jSons[i]);
                        end;

                except on E:Exception do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
                                exit;
                        end
                        else
                        begin
                                SetLength(result, 0);
                                SetLength(jSons, 0);
                                setLastErrCode(-99999999);
                                setLastErrMessage('결과처리 실패.[Malformed Json]');
                                exit;
                        end;

                end;
                end;
        end;
        

        
end;


function TStatementService.Delete(CorpNum : String; ItemCode:Integer;  MgtKey: String; UserID : String) : TResponse;
var
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '문서번호가 입력되지 않았습니다.';
                        Exit;
                end;
        end;
        
        try
                responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey,CorpNum,UserID,'','DELETE');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
                exit;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
                exit;
        end;
end;

function TStatementService.AttachFile(CorpNum : String; ItemCode:Integer; MgtKey : String; FilePath : String; UserID : String = '') : TResponse;
var
        responseJson : string;
        fileName : string;
        fileData : TFileStream;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '문서번호가 입력되지 않았습니다.';
                        Exit;
                end;
        end;

       fileName := ExtractFileName(FilePath);
       fileData := TFileStream.Create(FilePath,fmOpenRead);

       try
                try
                        responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey + '/Files',CorpNum,UserID,'Filedata',fileName,fileData);
                except
                        on le : EPopbillException do begin
                                if FIsThrowException then
                                begin
                                        raise EPopbillException.Create(le.code,le.Message);
                                        exit;
                                end
                                else
                                begin
                                        result.code := le.code;
                                        result.message := le.Message;
                                        exit;
                                end;
                        end;
                end;

       finally
                fileData.Free;
       end;

       if LastErrCode <> 0 then
       begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
       end
       else
       begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
                exit;
       end;
end;

function TStatementService.GetFiles(CorpNum: String; ItemCode:Integer; MgtKey : String) : TAttachedFileList;
var
        responseJson : string;
        jSons : ArrayOfString;
        i : integer;
begin
        try
                responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey + '/Files',CorpNum,'');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                exit;
        end
        else
        begin
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

                except on E:Exception do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
                                exit;
                        end
                        else
                        begin
                                SetLength(result, 0);
                                SetLength(jSons, 0);
                                setLastErrCode(-99999999);
                                setLastErrMessage('결과처리 실패.[Malformed Json]');
                                exit;
                        end;

                        end;
                end;
        end;



end;

function TStatementService.DeleteFile(CorpNum : String; ItemCode:Integer;  MgtKey: String; FileID : String; UserID : String = '') : TResponse;
var
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '문서번호가 입력되지 않았습니다.';
                        Exit;
                end;
        end;

        if FileID = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'파일 아이디가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '파일 아이디가 입력되지 않았습니다.';
                        Exit;
                end;
        end;

        try
                responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey + '/Files/' + FileID,CorpNum,UserID,'','DELETE');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
                exit;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
                exit;
        end;
end;

function TStatementService.GetPopUpURL(CorpNum: string; ItemCode:Integer; MgtKey : String;UserID : String = '') : string;
var
        responseJson : String;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result := '';
                        setLastErrCode(-99999999);
                        setLastErrMessage('문서번호가 입력되지 않았습니다.');
                        exit;
                end;
        end;

        try
                responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey +'?TG=POPUP',CorpNum,UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end;
                end;

        end;
end;

function TStatementService.GetViewURL(CorpNum: string; ItemCode:Integer; MgtKey : String;UserID : String = '') : string;
var
        responseJson : String;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result := '';
                        setLastErrCode(-99999999);
                        setLastErrMessage('문서번호가 입력되지 않았습니다.');
                        exit;
                end;
        end;

        try
                responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey +'?TG=VIEW',CorpNum,UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end;
                end;
        end;
end;

function TStatementService.GetPrintURL(CorpNum: string; ItemCode:Integer; MgtKey : String;UserID : String = '') : string;
var
        responseJson : String;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result := '';
                        setLastErrCode(-99999999);
                        setLastErrMessage('문서번호가 입력되지 않았습니다.');
                        exit;
                end;
        end;

        try
                responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey +'?TG=PRINT',CorpNum,UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end;
                end;
        end;
end;

function TStatementService.GetEPrintURL(CorpNum: string; ItemCode:Integer; MgtKey : String;UserID : String = '') : string;
var
        responseJson : String;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result := '';
                        setLastErrCode(-99999999);
                        setLastErrMessage('문서번호가 입력되지 않았습니다.');
                        exit;
                end;
        end;

        try
                responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey +'?TG=EPRINT',CorpNum,UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end;
                end;
        end;

end;

function TStatementService.GetMassPrintURL(CorpNum: string; ItemCode:Integer; MgtKeyList: Array Of String; UserID: String = '') : string;
var
        requestJson,responseJson:string;
        i : integer;
begin
        if Length(MgtKeyList) = 0 then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result := '';
                        setLastErrCode(-99999999);
                        setLastErrMessage('문서번호가 입력되지 않았습니다.');
                        exit;
                end;
        end;

        requestJson := '[';
        for i:=0 to Length(MgtKeyList) -1 do
        begin
                requestJson := requestJson + '"' + EscapeString(MgtKeyList[i]) + '"';
                if (i + 1) < Length(MgtKeyList) then requestJson := requestJson + ',';
        end;

        requestJson := requestJson + ']';

        try
                responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '?Print',
                                CorpNum,
                                UserID,
                                requestJson);

                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end;
                end;
        end;
end;

function TStatementService.GetMailURL(CorpNum: string; ItemCode:Integer; MgtKey : String;UserID : String = '') : string;
var
        responseJson : String;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'문서번호가 입력되지 않았습니다.');
                        Exit;
                end
                else
                begin
                        result := '';
                        setLastErrCode(-99999999);
                        setLastErrMessage('문서번호가 입력되지 않았습니다.');
                        exit;
                end;
        end;

        try
                responseJson := httpget('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey +'?TG=MAIL',CorpNum,UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end;
                end;
        end;
end;


function TStatementService.GetUnitCost(CorpNum : String;ItemCode:Integer) : Single;
var
        responseJson : string;
begin
        try
                responseJson := httpget('/Statement/'+IntToStr(ItemCode)+'?cfg=UNITCOST',CorpNum,'');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end
                        else
                        begin
                                result := 0.0;
                                exit;
                        end;
                end;
        end;


        if LastErrCode <> 0 then
        begin
                exit;
        end
        else
        begin
                result := strToFloat(getJSonString( responseJson,'unitCost'));
        end;
end;

function TStatementService.AttachStatement(CorpNum : String; ItemCode:Integer; MgtKey:String; SubItemCode :Integer; SubMgtKey :String) : TResponse;
var
        requestJson : string;
        responseJson : string;
begin

        try
                requestJson := '{"ItemCode":"'+EscapeString(IntToSTr(SubItemCode))+'","MgtKey":"'+EscapeString(SubMgtKey)+'"}';

                responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey+'/AttachStmt',CorpNum,'',requestJson,'');


        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;

end;

function TStatementService.DetachStatement(CorpNum : String; ItemCode:Integer; MgtKey:String; SubItemCode :Integer; SubMgtKey :String) : TResponse;
var
        requestJson : string;
        responseJson : string;
begin

        try
                requestJson := '{"ItemCode":"'+EscapeString(IntToSTr(SubItemCode))+'","MgtKey":"'+EscapeString(SubMgtKey)+'"}';
                responseJson := httppost('/Statement/'+ IntToStr(ItemCode) + '/'+MgtKey+'/DetachStmt',CorpNum,'',requestJson,'');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;
end;

function TStatementService.ListEmailConfig(CorpNum, UserID: String): TEmailConfigList;
var
        responseJson : string;
        jSons : ArrayOfString;
        i : integer;
begin
        try
                responseJson := httpget('/Statement/EmailSendConfig',CorpNum,UserID);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                exit;                                                                        
        end
        else
        begin
                try
                        jSons := ParseJsonList(responseJson);
                        SetLength(result,Length(jSons));

                        for i := 0 to Length(jSons)-1 do
                        begin
                                result[i] := TEmailConfig.Create;
                                result[i].EmailType := getJSonString (jSons[i],'emailType');
                                result[i].SendYN    := getJSonBoolean(jSons[i],'sendYN');
                        end;
                except on E:Exception do
                        raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
                end;
        end;


end;

Function BoolToStr(b:Boolean):String;
begin
    if b = true then BoolToStr:='True';
    if b = false then BoolToStr:='False';
end;

function TStatementService.UpdateEmailConfig(CorpNum, EmailType: String; SendYN: Boolean; UserID: String): TResponse;
var
        requestJson : string;
        responseJson : string;
begin

        if Trim(EmailType) = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'메일전송유형이 입력되지 않았습니다.');
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '메일전송유형이 입력되지 않았습니다.';
                        Exit;
                end;
        end;

        try
                requestJson := '{"EmailType":"'+EscapeString(EmailType)+'","SendYN":"'+EscapeString(BoolToStr(SendYN))+'"}';

                responseJson := httppost('/Statement/EmailSendConfig?EmailType=' + EmailType + '&SendYN=' + BoolToStr(SendYN),
                                        CorpNum,UserID,requestJson,'');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
                exit;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
                exit;
        end;
end;

//End Of Unit.
end.
