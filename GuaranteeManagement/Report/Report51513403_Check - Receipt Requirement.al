report 51513403 "Check - Receipt Requirement"
{
    // version NAVW14.00.01,PASS10.9.25

    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Check - Receipt Requirement.rdl';
    Caption = 'Check';

    dataset
    {
        dataitem(VoidGenJnlLine;"Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name","Journal Batch Name","Posting Date","Document No.");
            RequestFilterFields = "Journal Template Name","Journal Batch Name","Posting Date";

            trigger OnAfterGetRecord();
            begin
                CheckManagement.VoidCheck(VoidGenJnlLine);
            end;

            trigger OnPreDataItem();
            begin
                if CurrReport.PREVIEW then
                  ERROR(Text000);

                if UseCheckNo = '' then
                  ERROR(Text001);

                if TestPrint then
                  CurrReport.BREAK;

                if not ReprintChecks then
                  CurrReport.BREAK;

                if (GETFILTER("Line No.") <> '') or (GETFILTER("Document No.") <> '') then
                  ERROR(
                    Text002,FIELDCAPTION("Line No."),FIELDCAPTION("Document No."));
                SETRANGE("Bank Payment Type","Bank Payment Type"::"Computer Check");
                SETRANGE("Check Printed",true);
            end;
        }
        dataitem(GenJnlLine;"Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name","Journal Batch Name","Posting Date","Document No.");
            column(GenJnlLine_Journal_Template_Name;"Journal Template Name")
            {
            }
            column(GenJnlLine_Journal_Batch_Name;"Journal Batch Name")
            {
            }
            column(GenJnlLine_Line_No_;"Line No.")
            {
            }
            dataitem(CheckPages;"Integer")
            {
                DataItemTableView = SORTING(Number);
                column(CheckToAddr_1_;CheckToAddr[1])
                {
                }
                column(CheckDateText;CheckDateText)
                {
                }
                column(CheckNoText;CheckNoText)
                {
                }
                column(CheckNoTextCaption;CheckNoTextCaptionLbl)
                {
                }
                column(CheckPages_Number;Number)
                {
                }
                dataitem(PrintSettledLoop;"Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(NetAmount;NetAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalLineDiscount___LineDiscount;TotalLineDiscount - LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalLineAmount___LineAmount;TotalLineAmount - LineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalLineAmount___LineAmount2;TotalLineAmount - LineAmount2)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmount;LineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineDiscount;LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmount___LineDiscount;LineAmount + LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(DocNo;DocNo)
                    {
                    }
                    column(DocDate;DocDate)
                    {
                    }
                    column(CurrencyCode2;CurrencyCode2)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmount2;LineAmount2)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(ExtDocNo;ExtDocNo)
                    {
                    }
                    column(LineAmountCaption;LineAmountCaptionLbl)
                    {
                    }
                    column(LineDiscountCaption;LineDiscountCaptionLbl)
                    {
                    }
                    column(AmountCaption;AmountCaptionLbl)
                    {
                    }
                    column(DocNoCaption;DocNoCaptionLbl)
                    {
                    }
                    column(DocDateCaption;DocDateCaptionLbl)
                    {
                    }
                    column(Currency_CodeCaption;Currency_CodeCaptionLbl)
                    {
                    }
                    column(Your_Doc__No_Caption;Your_Doc__No_CaptionLbl)
                    {
                    }
                    column(TransportCaption;TransportCaptionLbl)
                    {
                    }
                    column(PrintSettledLoop_Number;Number)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        if not TestPrint then begin
                          if FoundLast then begin
                            if RemainingAmount <> 0 then begin
                              DocType := Text015;
                              DocNo := '';
                              ExtDocNo := '';
                              LineAmount := RemainingAmount;
                              LineAmount2 := RemainingAmount;
                              LineDiscount := 0;
                              RemainingAmount := 0;
                            end else
                              CurrReport.BREAK;
                          end else begin
                            case ApplyMethod of
                              ApplyMethod::OneLineOneEntry:
                                begin
                                  case BalancingType of
                                    BalancingType::Customer:
                                      begin
                                        CustLedgEntry.RESET;
                                        CustLedgEntry.SETCURRENTKEY("Document No.","Document Type","Customer No.");
                                        CustLedgEntry.SETRANGE("Document Type",GenJnlLine."Applies-to Doc. Type");
                                        CustLedgEntry.SETRANGE("Document No.",GenJnlLine."Applies-to Doc. No.");
                                        CustLedgEntry.SETRANGE("Customer No.",BalancingNo);
                                        CustLedgEntry.FIND('-');
                                        CustUpdateAmounts(CustLedgEntry,RemainingAmount);
                                      end;
                                    BalancingType::Vendor:
                                      begin
                                        VendLedgEntry.RESET;
                                        VendLedgEntry.SETCURRENTKEY("Document No.","Document Type","Vendor No.");
                                        VendLedgEntry.SETRANGE("Document Type",GenJnlLine."Applies-to Doc. Type");
                                        VendLedgEntry.SETRANGE("Document No.",GenJnlLine."Applies-to Doc. No.");
                                        VendLedgEntry.SETRANGE("Vendor No.",BalancingNo);
                                        VendLedgEntry.FIND('-');
                                        VendUpdateAmounts(VendLedgEntry,RemainingAmount);
                                      end;
                                  end;
                                  RemainingAmount := RemainingAmount - LineAmount2;
                                  FoundLast := true;
                                end;
                              ApplyMethod::OneLineID:
                                begin
                                  case BalancingType of
                                    BalancingType::Customer:
                                      begin
                                        CustUpdateAmounts(CustLedgEntry,RemainingAmount);
                                        FoundLast := (CustLedgEntry.NEXT = 0) or (RemainingAmount <= 0);
                                        if FoundLast and not FoundNegative then begin
                                          CustLedgEntry.SETRANGE(Positive,false);
                                          FoundLast := not CustLedgEntry.FIND('-');
                                          FoundNegative := true;
                                        end;
                                      end;
                                    BalancingType::Vendor:
                                      begin
                                        VendUpdateAmounts(VendLedgEntry,RemainingAmount);
                                        FoundLast := (VendLedgEntry.NEXT = 0) or (RemainingAmount <= 0);
                                        if FoundLast and not FoundNegative then begin
                                          VendLedgEntry.SETRANGE(Positive,false);
                                          FoundLast := not VendLedgEntry.FIND('-');
                                          FoundNegative := true;
                                        end;
                                      end;
                                  end;
                                  RemainingAmount := RemainingAmount - LineAmount2;
                                end;
                              ApplyMethod::MoreLinesOneEntry:
                                begin
                                  CurrentLineAmount := GenJnlLine2.Amount;
                                  LineAmount2 := CurrentLineAmount;

                                  if GenJnlLine2."Applies-to ID" <> '' then
                                    ERROR(
                                      Text016 +
                                      Text017);
                                  GenJnlLine2.TESTFIELD("Check Printed",false);
                                  GenJnlLine2.TESTFIELD("Bank Payment Type",GenJnlLine2."Bank Payment Type"::"Computer Check");

                                  if GenJnlLine2."Applies-to Doc. No." = '' then begin
                                    DocType := Text015;
                                    DocNo := '';
                                    ExtDocNo := '';
                                    LineAmount := CurrentLineAmount;
                                    LineDiscount := 0;
                                  end else begin
                                    case BalancingType of
                                      BalancingType::"G/L Account":
                                        begin
                                          DocType := FORMAT(GenJnlLine2."Document Type");
                                          DocNo := GenJnlLine2."Document No.";
                                          ExtDocNo := GenJnlLine2."External Document No.";
                                          LineAmount := CurrentLineAmount;
                                          LineDiscount := 0;
                                        end;
                                      BalancingType::Customer:
                                        begin
                                          CustLedgEntry.RESET;
                                          CustLedgEntry.SETCURRENTKEY("Document No.","Document Type","Customer No.");
                                          CustLedgEntry.SETRANGE("Document Type",GenJnlLine2."Applies-to Doc. Type");
                                          CustLedgEntry.SETRANGE("Document No.",GenJnlLine2."Applies-to Doc. No.");
                                          CustLedgEntry.SETRANGE("Customer No.",BalancingNo);
                                          CustLedgEntry.FIND('-');
                                          CustUpdateAmounts(CustLedgEntry,CurrentLineAmount);
                                          LineAmount := CurrentLineAmount;
                                        end;
                                      BalancingType::Vendor:
                                        begin
                                          VendLedgEntry.RESET;
                                          VendLedgEntry.SETCURRENTKEY("Document No.","Document Type","Vendor No.");
                                          VendLedgEntry.SETRANGE("Document Type",GenJnlLine2."Applies-to Doc. Type");
                                          VendLedgEntry.SETRANGE("Document No.",GenJnlLine2."Applies-to Doc. No.");
                                          VendLedgEntry.SETRANGE("Vendor No.",BalancingNo);
                                          VendLedgEntry.FIND('-');
                                          VendUpdateAmounts(VendLedgEntry,CurrentLineAmount);
                                          LineAmount := CurrentLineAmount;
                                        end;
                                      BalancingType::"Bank Account":
                                        begin
                                          DocType := FORMAT(GenJnlLine2."Document Type");
                                          DocNo := GenJnlLine2."Document No.";
                                          ExtDocNo := GenJnlLine2."External Document No.";
                                          LineAmount := CurrentLineAmount;
                                          LineDiscount := 0;
                                        end;
                                    end;
                                  end;
                                  FoundLast := GenJnlLine2.NEXT = 0;
                                end;
                            end;
                          end;

                          TotalLineAmount := TotalLineAmount + LineAmount2;
                          TotalLineDiscount := TotalLineDiscount + LineDiscount;
                        end else begin
                          if FoundLast then
                            CurrReport.BREAK;
                          FoundLast := true;
                          DocType := Text018;
                          DocNo := Text010;
                          ExtDocNo := Text010;
                          LineAmount := 0;
                          LineDiscount := 0;
                        end;
                    end;

                    trigger OnPreDataItem();
                    begin
                        if not TestPrint then
                          if FirstPage then begin
                            FoundLast := true;
                            case ApplyMethod of
                              ApplyMethod::OneLineOneEntry:
                                FoundLast := false;
                              ApplyMethod::OneLineID:
                                case BalancingType of
                                  BalancingType::Customer:
                                    begin
                                      CustLedgEntry.RESET;
                                      CustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive);
                                      CustLedgEntry.SETRANGE("Customer No.",BalancingNo);
                                      CustLedgEntry.SETRANGE(Open,true);
                                      CustLedgEntry.SETRANGE(Positive,true);
                                      CustLedgEntry.SETRANGE("Applies-to ID",GenJnlLine."Applies-to ID");
                                      FoundLast := not CustLedgEntry.FIND('-');
                                      if FoundLast then begin
                                        CustLedgEntry.SETRANGE(Positive,false);
                                        FoundLast := not CustLedgEntry.FIND('-');
                                        FoundNegative := true;
                                      end else
                                        FoundNegative := false;
                                    end;
                                  BalancingType::Vendor:
                                    begin
                                      VendLedgEntry.RESET;
                                      VendLedgEntry.SETCURRENTKEY("Vendor No.",Open,Positive);
                                      VendLedgEntry.SETRANGE("Vendor No.",BalancingNo);
                                      VendLedgEntry.SETRANGE(Open,true);
                                      VendLedgEntry.SETRANGE(Positive,true);
                                      VendLedgEntry.SETRANGE("Applies-to ID",GenJnlLine."Applies-to ID");
                                      FoundLast := not VendLedgEntry.FIND('-');
                                      if FoundLast then begin
                                        VendLedgEntry.SETRANGE(Positive,false);
                                        FoundLast := not VendLedgEntry.FIND('-');
                                        FoundNegative := true;
                                      end else
                                        FoundNegative := false;
                                    end;
                                end;
                              ApplyMethod::MoreLinesOneEntry:
                                FoundLast := false;
                            end;
                          end
                        else
                          FoundLast := false;
                    end;
                }
                dataitem(PrintCheck;"Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(CheckAmountText;CheckAmountText)
                    {
                    }
                    column(CheckDateText_Control2;CheckDateText)
                    {
                    }
                    column(DescriptionLine_2_;DescriptionLine[2])
                    {
                    }
                    column(DescriptionLine_1_;DescriptionLine[1])
                    {
                    }
                    column(CheckToAddr_1__Control7;CheckToAddr[1])
                    {
                    }
                    column(CheckToAddr_2_;CheckToAddr[2])
                    {
                    }
                    column(CheckToAddr_4_;CheckToAddr[4])
                    {
                    }
                    column(CheckToAddr_3_;CheckToAddr[3])
                    {
                    }
                    column(CheckToAddr_5_;CheckToAddr[5])
                    {
                    }
                    column(CompanyAddr_4_;CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr_8_;CompanyAddr[8])
                    {
                    }
                    column(CompanyAddr_7_;CompanyAddr[7])
                    {
                    }
                    column(CompanyAddr_6_;CompanyAddr[6])
                    {
                    }
                    column(CompanyAddr_5_;CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr_3_;CompanyAddr[3])
                    {
                    }
                    column(CheckNoText_Control21;CheckNoText)
                    {
                    }
                    column(CompanyAddr_2_;CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_1_;CompanyAddr[1])
                    {
                    }
                    column(TotalLineAmount;TotalLineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalText;TotalText)
                    {
                    }
                    column(VoidText;VoidText)
                    {
                    }
                    column(PrintCheck_Number;Number)
                    {
                    }

                    trigger OnAfterGetRecord();
                    var
                        RecordId1 : RecordID;
                    begin
                        if not TestPrint then begin
                          with GenJnlLine do begin
                            CheckLedgEntry.INIT;
                            CheckLedgEntry."Bank Account No." := BankAcc2."No.";
                            CheckLedgEntry."Posting Date" := "Posting Date";
                            CheckLedgEntry."Document Type" := "Document Type";
                            CheckLedgEntry."Document No." := UseCheckNo;
                            CheckLedgEntry.Description := Description;
                            CheckLedgEntry."Bank Payment Type" := "Bank Payment Type";
                            CheckLedgEntry."Bal. Account Type" := BalancingType;
                            CheckLedgEntry."Bal. Account No." := BalancingNo;
                            if FoundLast then begin
                              if TotalLineAmount < 0 then
                                ERROR(
                                  Text020,
                                  UseCheckNo,TotalLineAmount);
                              CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Printed;
                              CheckLedgEntry.Amount := TotalLineAmount;
                            end else begin
                              CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Voided;
                              CheckLedgEntry.Amount := 0;
                            end;
                            CheckLedgEntry."Check Date" := "Posting Date";
                            CheckLedgEntry."Check No." := UseCheckNo;
                            CheckManagement.InsertCheck(CheckLedgEntry,RecordId1);


                            if FoundLast then begin
                              CheckAmountText := FORMAT(CheckLedgEntry.Amount,0);
                              i := STRPOS(CheckAmountText,'.');
                              case true of
                                i = 0:
                                  CheckAmountText := CheckAmountText + '.00';
                                i = STRLEN(CheckAmountText) - 1:
                                  CheckAmountText := CheckAmountText + '0';
                                i > STRLEN(CheckAmountText) - 2:
                                  CheckAmountText := COPYSTR(CheckAmountText,1,i + 2);
                              end;
                              FormatNoText(DescriptionLine,CheckLedgEntry.Amount,BankAcc2."Currency Code");
                              VoidText := '';
                            end else begin
                              CLEAR(CheckAmountText);
                              CLEAR(DescriptionLine);
                              DescriptionLine[1] := Text021;
                              DescriptionLine[2] := DescriptionLine[1];
                              VoidText := Text022;
                            end;
                          end;
                        end else begin
                          with GenJnlLine do begin
                            CheckLedgEntry.INIT;
                            CheckLedgEntry."Bank Account No." := BankAcc2."No.";
                            CheckLedgEntry."Posting Date" := "Posting Date";
                            CheckLedgEntry."Document No." := UseCheckNo;
                            CheckLedgEntry.Description := Text023;
                            CheckLedgEntry."Bank Payment Type" := "Bank Payment Type"::"Computer Check";
                            CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::"Test Print";
                            CheckLedgEntry."Check Date" := "Posting Date";
                            CheckLedgEntry."Check No." := UseCheckNo;
                            CheckManagement.InsertCheck(CheckLedgEntry,RecordId1);

                            CheckAmountText := Text024;
                            DescriptionLine[1] := Text025;
                            DescriptionLine[2] := DescriptionLine[1];
                            VoidText := Text022;
                          end;
                        end;

                        ChecksPrinted := ChecksPrinted + 1;
                        FirstPage := false;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if FoundLast then
                      CurrReport.BREAK;

                    UseCheckNo := INCSTR(UseCheckNo);
                    if not TestPrint then
                      CheckNoText := UseCheckNo
                    else
                      CheckNoText := Text011;
                end;

                trigger OnPostDataItem();
                begin
                    if not TestPrint then begin
                      if UseCheckNo <> GenJnlLine."Document No." then begin
                        GenJnlLine3.RESET;
                        GenJnlLine3.SETCURRENTKEY("Journal Template Name","Journal Batch Name","Posting Date","Document No.");
                        GenJnlLine3.SETRANGE("Journal Template Name",GenJnlLine."Journal Template Name");
                        GenJnlLine3.SETRANGE("Journal Batch Name",GenJnlLine."Journal Batch Name");
                        GenJnlLine3.SETRANGE("Posting Date",GenJnlLine."Posting Date");
                        GenJnlLine3.SETRANGE("Document No.",UseCheckNo);
                        if GenJnlLine3.FIND('-') then
                          GenJnlLine3.FIELDERROR("Document No.",STRSUBSTNO(Text013,UseCheckNo));
                      end;

                      if ApplyMethod <> ApplyMethod::MoreLinesOneEntry then begin
                        GenJnlLine3 := GenJnlLine;
                        GenJnlLine3.TESTFIELD("Posting No. Series",'');
                        GenJnlLine3."Document No." := UseCheckNo;
                        GenJnlLine3."Check Printed" := true;
                        GenJnlLine3.MODIFY;
                      end else begin
                        if GenJnlLine2.FIND('-') then begin
                          HighestLineNo := GenJnlLine2."Line No.";
                          repeat
                            if GenJnlLine2."Line No." > HighestLineNo then
                              HighestLineNo := GenJnlLine2."Line No.";
                            GenJnlLine3 := GenJnlLine2;
                            GenJnlLine3.TESTFIELD("Posting No. Series",'');
                            GenJnlLine3."Bal. Account No." := '';
                            GenJnlLine3."Bank Payment Type" := GenJnlLine3."Bank Payment Type"::" ";
                            GenJnlLine3."Document No." := UseCheckNo;
                            GenJnlLine3."Check Printed" := true;
                            GenJnlLine3.VALIDATE(Amount);
                            GenJnlLine3.MODIFY;
                          until GenJnlLine2.NEXT = 0;
                        end;

                        GenJnlLine3.RESET;
                        GenJnlLine3 := GenJnlLine;
                        GenJnlLine3.SETRANGE("Journal Template Name",GenJnlLine."Journal Template Name");
                        GenJnlLine3.SETRANGE("Journal Batch Name",GenJnlLine."Journal Batch Name");
                        GenJnlLine3."Line No." := HighestLineNo;
                        if GenJnlLine3.NEXT = 0 then
                          GenJnlLine3."Line No." := HighestLineNo + 10000
                        else begin
                          while GenJnlLine3."Line No." = HighestLineNo + 1 do begin
                            HighestLineNo := GenJnlLine3."Line No.";
                            if GenJnlLine3.NEXT = 0 then
                              GenJnlLine3."Line No." := HighestLineNo + 20000;
                          end;
                          GenJnlLine3."Line No." := (GenJnlLine3."Line No." + HighestLineNo) div 2;
                        end;
                        GenJnlLine3.INIT;
                        GenJnlLine3.VALIDATE("Posting Date",GenJnlLine."Posting Date");
                        GenJnlLine3."Document Type" := GenJnlLine."Document Type";
                        GenJnlLine3."Document No." := UseCheckNo;
                        GenJnlLine3."Account Type" := GenJnlLine3."Account Type"::"Bank Account";
                        GenJnlLine3.VALIDATE("Account No.",BankAcc2."No.");
                        if BalancingType <> BalancingType::"G/L Account" then
                          GenJnlLine3.Description := STRSUBSTNO(Text014,SELECTSTR(BalancingType + 1,Text062),BalancingNo);
                        GenJnlLine3.VALIDATE(Amount,-TotalLineAmount);
                        GenJnlLine3."Bank Payment Type" := GenJnlLine3."Bank Payment Type"::"Computer Check";
                        GenJnlLine3."Check Printed" := true;
                        GenJnlLine3."Source Code" := GenJnlLine."Source Code";
                        GenJnlLine3."Reason Code" := GenJnlLine."Reason Code";
                        GenJnlLine3."Allow Zero-Amount Posting" := true;
                        GenJnlLine3.INSERT;
                      end;
                    end;

                    BankAcc2."Last Check No." := UseCheckNo;
                    BankAcc2.MODIFY;

                    COMMIT;
                    CLEAR(CheckManagement);
                end;

                trigger OnPreDataItem();
                begin
                    FirstPage := true;
                    FoundLast := false;
                    TotalLineAmount := 0;
                    TotalLineDiscount := 0;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if OneCheckPrVendor and (GenJnlLine."Currency Code" <> '') and
                   (GenJnlLine."Currency Code" <> Currency.Code)
                then begin
                  Currency.GET(GenJnlLine."Currency Code");
                  Currency.TESTFIELD("Conv. LCY Rndg. Debit Acc.");
                  Currency.TESTFIELD("Conv. LCY Rndg. Credit Acc.");
                end;

                if not TestPrint then begin
                  if Amount = 0 then
                    CurrReport.SKIP;

                  TESTFIELD("Bal. Account Type","Bal. Account Type"::"Bank Account");
                  if "Bal. Account No." <> BankAcc2."No." then
                    CurrReport.SKIP;

                  if ("Account No." <> '') and ("Bal. Account No." <> '') then begin
                    BalancingType := "Account Type";
                    BalancingNo := "Account No.";
                    RemainingAmount := Amount;
                    if OneCheckPrVendor then begin
                      ApplyMethod := ApplyMethod::MoreLinesOneEntry;
                      GenJnlLine2.RESET;
                      GenJnlLine2.SETCURRENTKEY("Journal Template Name","Journal Batch Name","Posting Date","Document No.");
                      GenJnlLine2.SETRANGE("Journal Template Name","Journal Template Name");
                      GenJnlLine2.SETRANGE("Journal Batch Name","Journal Batch Name");
                      GenJnlLine2.SETRANGE("Posting Date","Posting Date");
                      GenJnlLine2.SETRANGE("Document No.","Document No.");
                      GenJnlLine2.SETRANGE("Account Type","Account Type");
                      GenJnlLine2.SETRANGE("Account No.","Account No.");
                      GenJnlLine2.SETRANGE("Bal. Account Type","Bal. Account Type");
                      GenJnlLine2.SETRANGE("Bal. Account No.","Bal. Account No.");
                      GenJnlLine2.SETRANGE("Bank Payment Type","Bank Payment Type");
                      GenJnlLine2.FIND('-');
                      RemainingAmount := 0;
                    end else
                      if "Applies-to Doc. No." <> '' then
                        ApplyMethod := ApplyMethod::OneLineOneEntry
                      else
                        if "Applies-to ID" <> '' then
                          ApplyMethod := ApplyMethod::OneLineID
                        else
                          ApplyMethod := ApplyMethod::Payment;
                  end else
                    if "Account No." = '' then
                      FIELDERROR("Account No.",Text004)
                    else
                      FIELDERROR("Bal. Account No.",Text004);

                  CLEAR(CheckToAddr);
                  ContactText := '';
                  CLEAR(SalesPurchPerson);
                  case BalancingType of
                    BalancingType::"G/L Account":
                      begin
                        CheckToAddr[1] := GenJnlLine.Description;
                      end;
                    BalancingType::Customer:
                      begin
                        Cust.GET(BalancingNo);
                        if Cust.Blocked = Cust.Blocked::All then
                          ERROR(Text064,Cust.FIELDCAPTION(Blocked),Cust.Blocked,Cust.TABLECAPTION,Cust."No.");
                        Cust.Contact := '';
                        FormatAddr.Customer(CheckToAddr,Cust);
                        if BankAcc2."Currency Code" <> "Currency Code" then
                          ERROR(Text005);
                        if Cust."Salesperson Code" <> '' then begin
                          ContactText := Text006;
                          SalesPurchPerson.GET(Cust."Salesperson Code");
                        end;
                      end;
                    BalancingType::Vendor:
                      begin
                        Vend.GET(BalancingNo);
                        if Vend.Blocked in [Vend.Blocked::All,Vend.Blocked::Payment] then
                          ERROR(Text064,Vend.FIELDCAPTION(Blocked),Vend.Blocked,Vend.TABLECAPTION,Vend."No.");
                        Vend.Contact := '';
                        FormatAddr.Vendor(CheckToAddr,Vend);
                        if BankAcc2."Currency Code" <> "Currency Code" then
                          ERROR(Text005);
                        if Vend."Purchaser Code" <> '' then begin
                          ContactText := Text007;
                          SalesPurchPerson.GET(Vend."Purchaser Code");
                        end;
                      end;
                    BalancingType::"Bank Account":
                      begin
                        BankAcc.GET(BalancingNo);
                        BankAcc.TESTFIELD(Blocked,false);
                        BankAcc.Contact := '';
                        FormatAddr.BankAcc(CheckToAddr,BankAcc);
                        if BankAcc2."Currency Code" <> BankAcc."Currency Code" then
                          ERROR(Text008);
                        if BankAcc."Our Contact Code" <> '' then begin
                          ContactText := Text009;
                          SalesPurchPerson.GET(BankAcc."Our Contact Code");
                        end;
                      end;
                  end;

                  CheckDateText := FORMAT("Posting Date",0,4);
                end else begin
                  if ChecksPrinted > 0 then
                    CurrReport.BREAK;
                  BalancingType := BalancingType::Vendor;
                  BalancingNo := Text010;
                  CLEAR(CheckToAddr);
                  for i := 1 to 5 do
                    CheckToAddr[i] := Text003;
                  ContactText := '';
                  CLEAR(SalesPurchPerson);
                  CheckNoText := Text011;
                  CheckDateText := Text012;
                end;
            end;

            trigger OnPreDataItem();
            begin
                GenJnlLine.COPY(VoidGenJnlLine);
                CompanyInfo.GET;
                if not TestPrint then begin
                  FormatAddr.Company(CompanyAddr,CompanyInfo);
                  BankAcc2.GET(BankAcc2."No.");
                  BankAcc2.TESTFIELD(Blocked,false);
                  COPY(VoidGenJnlLine);
                  SETRANGE("Bank Payment Type","Bank Payment Type"::"Computer Check");
                  SETRANGE("Check Printed",false);
                end else begin
                  CLEAR(CompanyAddr);
                  for i := 1 to 5 do
                    CompanyAddr[i] := Text003;
                end;
                ChecksPrinted := 0;

                SETRANGE("Account Type",GenJnlLine."Account Type"::"Fixed Asset");
                if FIND('-') then
                  GenJnlLine.FIELDERROR("Account Type");
                SETRANGE("Account Type");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        InitTextVariable;
    end;

    var
        Text000 : Label 'Preview is not allowed.';
        Text001 : Label 'Last Check No. must be filled in.';
        Text002 : Label 'Filters on %1 and %2 are not allowed.';
        Text003 : Label 'XXXXXXXXXXXXXXXX';
        Text004 : Label 'must be entered.';
        Text005 : Label 'The Bank Account and the General Journal Line must have the same currency.';
        Text006 : Label 'Salesperson';
        Text007 : Label 'Purchaser';
        Text008 : Label 'Both Bank Accounts must have the same currency.';
        Text009 : Label 'Our Contact';
        Text010 : Label 'XXXXXXXXXX';
        Text011 : Label 'XXXX';
        Text012 : Label 'XX.XXXXXXXXXX.XXXX';
        Text013 : Label '%1 already exists.';
        Text014 : Label 'Check for %1 %2';
        Text015 : Label 'Payment';
        Text016 : Label 'In the Check report, One Check per Vendor and Document No.\';
        Text017 : Label 'must not be activated when Applies-to ID is specified in the journal lines.';
        Text018 : Label 'XXX';
        Text019 : Label 'Total';
        Text020 : Label 'The total amount of check %1 is %2. The amount must be positive.';
        Text021 : Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        Text022 : Label 'NON-NEGOTIABLE';
        Text023 : Label 'Test print';
        Text024 : Label 'XXXX.XX';
        Text025 : Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text026 : Label 'ZERO';
        Text027 : Label 'HUNDRED';
        Text028 : Label 'AND';
        Text029 : Label '%1 results in a written number that is too long.';
        Text030 : Label '" is already applied to %1 %2 for customer %3."';
        Text031 : Label '" is already applied to %1 %2 for vendor %3."';
        Text032 : Label 'ONE';
        Text033 : Label 'TWO';
        Text034 : Label 'THREE';
        Text035 : Label 'FOUR';
        Text036 : Label 'FIVE';
        Text037 : Label 'SIX';
        Text038 : Label 'SEVEN';
        Text039 : Label 'EIGHT';
        Text040 : Label 'NINE';
        Text041 : Label 'TEN';
        Text042 : Label 'ELEVEN';
        Text043 : Label 'TWELVE';
        Text044 : Label 'THIRTEEN';
        Text045 : Label 'FOURTEEN';
        Text046 : Label 'FIFTEEN';
        Text047 : Label 'SIXTEEN';
        Text048 : Label 'SEVENTEEN';
        Text049 : Label 'EIGHTEEN';
        Text050 : Label 'NINETEEN';
        Text051 : Label 'TWENTY';
        Text052 : Label 'THIRTY';
        Text053 : Label 'FORTY';
        Text054 : Label 'FIFTY';
        Text055 : Label 'SIXTY';
        Text056 : Label 'SEVENTY';
        Text057 : Label 'EIGHTY';
        Text058 : Label 'NINETY';
        Text059 : Label 'THOUSAND';
        Text060 : Label 'MILLION';
        Text061 : Label 'BILLION';
        CompanyInfo : Record "Company Information";
        SalesPurchPerson : Record "Salesperson/Purchaser";
        GenJnlLine2 : Record "Gen. Journal Line";
        GenJnlLine3 : Record "Gen. Journal Line";
        Cust : Record Customer;
        CustLedgEntry : Record "Cust. Ledger Entry";
        Vend : Record Vendor;
        VendLedgEntry : Record "Vendor Ledger Entry";
        BankAcc : Record "Bank Account";
        BankAcc2 : Record "Bank Account";
        CheckLedgEntry : Record "Check Ledger Entry";
        Currency : Record Currency;
        FormatAddr : Codeunit "Format Address";
        CheckManagement : Codeunit CheckManagement;
        CompanyAddr : array [8] of Text[50];
        CheckToAddr : array [8] of Text[50];
        OnesText : array [20] of Text[30];
        TensText : array [10] of Text[30];
        ExponentText : array [5] of Text[30];
        BalancingType : Option "G/L Account",Customer,Vendor,"Bank Account";
        BalancingNo : Code[20];
        ContactText : Text[30];
        CheckNoText : Text[30];
        CheckDateText : Text[30];
        CheckAmountText : Text[30];
        DescriptionLine : array [2] of Text[80];
        DocType : Text[30];
        DocNo : Text[30];
        ExtDocNo : Text[30];
        VoidText : Text[30];
        LineAmount : Decimal;
        LineDiscount : Decimal;
        TotalLineAmount : Decimal;
        TotalLineDiscount : Decimal;
        RemainingAmount : Decimal;
        CurrentLineAmount : Decimal;
        UseCheckNo : Code[20];
        FoundLast : Boolean;
        ReprintChecks : Boolean;
        TestPrint : Boolean;
        FirstPage : Boolean;
        OneCheckPrVendor : Boolean;
        FoundNegative : Boolean;
        ApplyMethod : Option Payment,OneLineOneEntry,OneLineID,MoreLinesOneEntry;
        ChecksPrinted : Integer;
        HighestLineNo : Integer;
        PreprintedStub : Boolean;
        TotalText : Text[10];
        DocDate : Date;
        i : Integer;
        Text062 : Label 'G/L Account,Customer,Vendor,Bank Account';
        CurrencyCode2 : Code[10];
        NetAmount : Text[30];
        CurrencyExchangeRate : Record "Currency Exchange Rate";
        LineAmount2 : Decimal;
        Text063 : Label 'Net Amount %1';
        GLSetup : Record "General Ledger Setup";
        Text064 : Label '%1 must not be %2 for %3 %4.';
        CheckNoTextCaptionLbl : Label 'Check No.';
        LineAmountCaptionLbl : Label 'Net Amount';
        LineDiscountCaptionLbl : Label 'Discount';
        AmountCaptionLbl : Label 'Amount';
        DocNoCaptionLbl : Label 'Document No.';
        DocDateCaptionLbl : Label 'Document Date';
        Currency_CodeCaptionLbl : Label 'Currency Code';
        Your_Doc__No_CaptionLbl : Label 'Your Doc. No.';
        TransportCaptionLbl : Label 'Transport';

    procedure FormatNoText(var NoText : array [2] of Text[80];No : Decimal;CurrencyCode : Code[10]);
    var
        PrintExponent : Boolean;
        Ones : Integer;
        Tens : Integer;
        Hundreds : Integer;
        Exponent : Integer;
        NoTextIndex : Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '****';

        if No < 1 then
          AddToNoText(NoText,NoTextIndex,PrintExponent,Text026)
        else begin
          for Exponent := 4 downto 1 do begin
            PrintExponent := false;
            Ones := No div POWER(1000,Exponent - 1);
            Hundreds := Ones div 100;
            Tens := (Ones mod 100) div 10;
            Ones := Ones mod 10;
            if Hundreds > 0 then begin
              AddToNoText(NoText,NoTextIndex,PrintExponent,OnesText[Hundreds]);
              AddToNoText(NoText,NoTextIndex,PrintExponent,Text027);
            end;
            if Tens >= 2 then begin
              AddToNoText(NoText,NoTextIndex,PrintExponent,TensText[Tens]);
              if Ones > 0 then
                AddToNoText(NoText,NoTextIndex,PrintExponent,OnesText[Ones]);
            end else
              if (Tens * 10 + Ones) > 0 then
                AddToNoText(NoText,NoTextIndex,PrintExponent,OnesText[Tens * 10 + Ones]);
            if PrintExponent and (Exponent > 1) then
              AddToNoText(NoText,NoTextIndex,PrintExponent,ExponentText[Exponent]);
            No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000,Exponent - 1);
          end;
        end;

        AddToNoText(NoText,NoTextIndex,PrintExponent,Text028);
        AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100) + '/100');

        if CurrencyCode <> '' then
          AddToNoText(NoText,NoTextIndex,PrintExponent,CurrencyCode);
    end;

    local procedure AddToNoText(var NoText : array [2] of Text[80];var NoTextIndex : Integer;var PrintExponent : Boolean;AddText : Text[30]);
    begin
        PrintExponent := true;

        while STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) do begin
          NoTextIndex := NoTextIndex + 1;
          if NoTextIndex > ARRAYLEN(NoText) then
            ERROR(Text029,AddText);
        end;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText,'<');
    end;

    local procedure CustUpdateAmounts(var CustLedgEntry2 : Record "Cust. Ledger Entry";RemainingAmount2 : Decimal);
    begin
        if (ApplyMethod = ApplyMethod::OneLineOneEntry) or
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        then begin
          GenJnlLine3.RESET;
          GenJnlLine3.SETCURRENTKEY(
            "Account Type","Account No.","Applies-to Doc. Type","Applies-to Doc. No.");
          GenJnlLine3.SETRANGE("Account Type",GenJnlLine3."Account Type"::Customer);
          GenJnlLine3.SETRANGE("Account No.",CustLedgEntry2."Customer No.");
          GenJnlLine3.SETRANGE("Applies-to Doc. Type",CustLedgEntry2."Document Type");
          GenJnlLine3.SETRANGE("Applies-to Doc. No.",CustLedgEntry2."Document No.");
          if ApplyMethod = ApplyMethod::OneLineOneEntry then
            GenJnlLine3.SETFILTER("Line No.",'<>%1',GenJnlLine."Line No.")
          else
            GenJnlLine3.SETFILTER("Line No.",'<>%1',GenJnlLine2."Line No.");
          if CustLedgEntry2."Document Type" <> CustLedgEntry2."Document Type"::" " then
            if GenJnlLine3.FIND('-') then
              GenJnlLine3.FIELDERROR(
                "Applies-to Doc. No.",
                STRSUBSTNO(
                  Text030,
                  CustLedgEntry2."Document Type",CustLedgEntry2."Document No.",
                  CustLedgEntry2."Customer No."));
        end;

        DocType := FORMAT(CustLedgEntry2."Document Type");
        DocNo := CustLedgEntry2."Document No.";
        ExtDocNo := CustLedgEntry2."External Document No.";
        DocDate := CustLedgEntry2."Posting Date";
        CurrencyCode2 := CustLedgEntry2."Currency Code";

        CustLedgEntry2.CALCFIELDS("Remaining Amount");

        LineAmount := -(CustLedgEntry2."Remaining Amount" - CustLedgEntry2."Remaining Pmt. Disc. Possible"-
          CustLedgEntry2."Accepted Payment Tolerance");
        LineAmount2 :=
          ROUND(
            ExchangeAmt(CustLedgEntry2."Posting Date",GenJnlLine."Currency Code",CurrencyCode2,LineAmount),
            Currency."Amount Rounding Precision");

        if ((CustLedgEntry2."Document Type" = CustLedgEntry2."Document Type"::Invoice) and
           (GenJnlLine."Posting Date" <= CustLedgEntry2."Pmt. Discount Date") and
           (LineAmount2 <= RemainingAmount2)) or CustLedgEntry2."Accepted Pmt. Disc. Tolerance"
        then begin
          LineDiscount := -CustLedgEntry2."Remaining Pmt. Disc. Possible";
          if CustLedgEntry2."Accepted Payment Tolerance" <> 0 then
            LineDiscount := LineDiscount - CustLedgEntry2."Accepted Payment Tolerance";
        end else begin
          if RemainingAmount2 >=
             ROUND(
              -(ExchangeAmt(CustLedgEntry2."Posting Date",GenJnlLine."Currency Code",CurrencyCode2,
                CustLedgEntry2."Remaining Amount")),Currency."Amount Rounding Precision")
          then
            LineAmount2 :=
              ROUND(
                -(ExchangeAmt(CustLedgEntry2."Posting Date",GenJnlLine."Currency Code",CurrencyCode2,
                  CustLedgEntry2."Remaining Amount")),Currency."Amount Rounding Precision")
          else begin
            LineAmount2 := RemainingAmount2;
            LineAmount :=
              ROUND(
                ExchangeAmt(CustLedgEntry2."Posting Date",CurrencyCode2,GenJnlLine."Currency Code",
                LineAmount2),Currency."Amount Rounding Precision");
          end;
          LineDiscount := 0;
        end;
    end;

    local procedure VendUpdateAmounts(var VendLedgEntry2 : Record "Vendor Ledger Entry";RemainingAmount2 : Decimal);
    begin
        if (ApplyMethod = ApplyMethod::OneLineOneEntry) or
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        then begin
          GenJnlLine3.RESET;
          GenJnlLine3.SETCURRENTKEY(
            "Account Type","Account No.","Applies-to Doc. Type","Applies-to Doc. No.");
          GenJnlLine3.SETRANGE("Account Type",GenJnlLine3."Account Type"::Vendor);
          GenJnlLine3.SETRANGE("Account No.",VendLedgEntry2."Vendor No.");
          GenJnlLine3.SETRANGE("Applies-to Doc. Type",VendLedgEntry2."Document Type");
          GenJnlLine3.SETRANGE("Applies-to Doc. No.",VendLedgEntry2."Document No.");
          if ApplyMethod = ApplyMethod::OneLineOneEntry then
            GenJnlLine3.SETFILTER("Line No.",'<>%1',GenJnlLine."Line No.")
          else
            GenJnlLine3.SETFILTER("Line No.",'<>%1',GenJnlLine2."Line No.");
          if VendLedgEntry2."Document Type" <> VendLedgEntry2."Document Type"::" " then
            if GenJnlLine3.FIND('-') then
              GenJnlLine3.FIELDERROR(
                "Applies-to Doc. No.",
                STRSUBSTNO(
                  Text031,
                  VendLedgEntry2."Document Type",VendLedgEntry2."Document No.",
                  VendLedgEntry2."Vendor No."));
        end;

        DocType := FORMAT(VendLedgEntry2."Document Type");
        DocNo := VendLedgEntry2."Document No.";
        ExtDocNo := VendLedgEntry2."External Document No.";
        DocDate := VendLedgEntry2."Posting Date";
        CurrencyCode2 := VendLedgEntry2."Currency Code";
        VendLedgEntry2.CALCFIELDS("Remaining Amount");

        LineAmount := -(VendLedgEntry2."Remaining Amount" - VendLedgEntry2."Remaining Pmt. Disc. Possible" -
          VendLedgEntry2."Accepted Payment Tolerance");

        LineAmount2 :=
          ROUND(
            ExchangeAmt(VendLedgEntry2."Posting Date",GenJnlLine."Currency Code",CurrencyCode2,LineAmount),
            Currency."Amount Rounding Precision");

        if (((VendLedgEntry2."Document Type" = VendLedgEntry2."Document Type"::Invoice) or
           (VendLedgEntry2."Document Type" = VendLedgEntry2."Document Type"::"Credit Memo")) and
           (GenJnlLine."Posting Date" <= VendLedgEntry2."Pmt. Discount Date") and
           (LineAmount2 <= RemainingAmount2)) or VendLedgEntry2."Accepted Pmt. Disc. Tolerance"
        then begin
          LineDiscount := -VendLedgEntry2."Remaining Pmt. Disc. Possible";
          if VendLedgEntry2."Accepted Payment Tolerance" <> 0 then
            LineDiscount := LineDiscount - VendLedgEntry2."Accepted Payment Tolerance";
        end else begin
         if RemainingAmount2 >=
             ROUND(
              -(ExchangeAmt(VendLedgEntry2."Posting Date",GenJnlLine."Currency Code",CurrencyCode2,
                VendLedgEntry2."Amount to Apply")),Currency."Amount Rounding Precision")
          then begin
            LineAmount2 :=
              ROUND(
                -(ExchangeAmt(VendLedgEntry2."Posting Date",GenJnlLine."Currency Code",CurrencyCode2,
                  VendLedgEntry2."Amount to Apply")),Currency."Amount Rounding Precision");
            LineAmount :=
              ROUND(
                ExchangeAmt(VendLedgEntry2."Posting Date",CurrencyCode2,GenJnlLine."Currency Code",
                LineAmount2),Currency."Amount Rounding Precision");
          end else begin
            LineAmount2 := RemainingAmount2;
            LineAmount :=
              ROUND(
                ExchangeAmt(VendLedgEntry2."Posting Date",CurrencyCode2,GenJnlLine."Currency Code",
                LineAmount2),Currency."Amount Rounding Precision");
          end;
          LineDiscount := 0;
        end;
    end;

    procedure InitTextVariable();
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text060;
        ExponentText[4] := Text061;
    end;

    procedure InitializeRequest(BankAcc : Code[20];LastCheckNo : Code[20];NewOneCheckPrVend : Boolean;NewReprintChecks : Boolean;NewTestPrint : Boolean;NewPreprintedStub : Boolean);
    begin
        if BankAcc <> '' then
          if BankAcc2.GET(BankAcc) then begin
            UseCheckNo := LastCheckNo;
            OneCheckPrVendor := NewOneCheckPrVend;
            ReprintChecks := NewReprintChecks;
            TestPrint := NewTestPrint;
            PreprintedStub := NewPreprintedStub;
          end;
    end;

    procedure ExchangeAmt(PostingDate : Date;CurrencyCode : Code[10];CurrencyCode2 : Code[10];Amount : Decimal) Amount2 : Decimal;
    begin
        if (CurrencyCode <> '')  and (CurrencyCode2 = '') then
           Amount2 :=
             CurrencyExchangeRate.ExchangeAmtLCYToFCY(
               PostingDate,CurrencyCode,Amount,CurrencyExchangeRate.ExchangeRate(PostingDate,CurrencyCode))
        else if (CurrencyCode = '') and (CurrencyCode2 <> '') then
          Amount2 :=
            CurrencyExchangeRate.ExchangeAmtFCYToLCY(
              PostingDate,CurrencyCode2,Amount,CurrencyExchangeRate.ExchangeRate(PostingDate,CurrencyCode2))
        else if (CurrencyCode <> '') and (CurrencyCode2 <> '') and (CurrencyCode <> CurrencyCode2) then
          Amount2 := CurrencyExchangeRate.ExchangeAmtFCYToFCY(PostingDate,CurrencyCode2,CurrencyCode,Amount)
        else
          Amount2 := Amount;
    end;

    procedure CGCFormatNoText(var NoText : array [2] of Text[80];No : Decimal);
    var
        PrintExponent : Boolean;
        Ones : Integer;
        Tens : Integer;
        Hundreds : Integer;
        Exponent : Integer;
        NoTextIndex : Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;

        if No < 1 then
          AddToNoText(NoText,NoTextIndex,PrintExponent,Text026)
        else begin
          for Exponent := 4 downto 1 do begin
            PrintExponent := false;
            Ones := No div POWER(1000,Exponent - 1);
            Hundreds := Ones div 100;
            Tens := (Ones mod 100) div 10;
            Ones := Ones mod 10;
            if Hundreds > 0 then begin
              AddToNoText(NoText,NoTextIndex,PrintExponent,OnesText[Hundreds]);
              AddToNoText(NoText,NoTextIndex,PrintExponent,Text027);
            end;
            if Tens >= 2 then begin
              AddToNoText(NoText,NoTextIndex,PrintExponent,TensText[Tens]);
              if Ones > 0 then
                AddToNoText(NoText,NoTextIndex,PrintExponent,OnesText[Ones]);
            end else
              if (Tens * 10 + Ones) > 0 then
                AddToNoText(NoText,NoTextIndex,PrintExponent,OnesText[Tens * 10 + Ones]);
            if PrintExponent and (Exponent > 1) then
              AddToNoText(NoText,NoTextIndex,PrintExponent,ExponentText[Exponent]);
            No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000,Exponent - 1);
          end;
        end;
    end;
}

