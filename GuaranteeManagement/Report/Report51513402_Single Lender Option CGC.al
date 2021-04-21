report 51513402 "Single Lender Option CGC"
{
    Caption = 'Single Lender Option CGC';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Single Lender Option CGC.rdl';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = sorting("Primary Key");

            column(Name_; Name)
            {

            }
            column(Picture; Picture)
            {

            }
            column(E_Mail; "E-Mail")
            {

            }
            column(Home_Page; "Home Page")
            {

            }
            column(Address; Address)
            {

            }
            column(Phone_No_; "Phone No.")
            {

            }

            dataitem("Lenders Option Single CGC"; "Lenders Option Single CGC")
            {

                column(Description; Description)
                {

                }
                column(Reference_No_; "Reference No.")
                {

                }
                column(No__of_Loans; "No. of Loans")
                {

                }
                column(From_CGC_No_; "From CGC No.")
                {

                }
                column(To_CGC_No_; "To CGC No.")
                {

                }

                Column(BankAddr_1_; BankAddr[1])
                {

                }
                Column(BankAddr_2_; BankAddr[2])
                {

                }
                column(BankAddr_3_; BankAddr[3])
                {

                }
                Column(BankAddr_4_; BankAddr[4])
                {

                }
                Column(BankAddr_5_; BankAddr[5])
                {

                }
                Column(BankAddr_6_; BankAddr[6])
                {

                }
                Column(CGC_Text__1__1_; "CGC Text"[1] [1])
                {

                }
                column(FORMAT___Reference_Date___0____Day___Month___Year4___; FORMAT("Reference Date", 0, '<Day>/<Month>/<Year4>'))
                {

                }

                Column(CGC_Text__1__2_; "CGC Text"[1] [2])
                {

                }
                Column(CGC_Text__1__3_; "CGC Text"[1] [3])
                {

                }
                Column(CGC_Text__1__4_; "CGC Text"[1] [4])
                {

                }

                Column(CGC_Text__1__5_; "CGC Text"[1] [5])
                {

                }
                Column(CGC_Text__2__1_; "CGC Text"[2] [1])
                {

                }

                Column(CGC_Text__2__2_; "CGC Text"[2] [2])
                {

                }
                Column(CGC_Text__2__3_; "CGC Text"[2] [3])
                {

                }
                Column(CGC_Text__2__4_; "CGC Text"[2] [4])
                {

                }
                Column(CGC_Text__2__5_; "CGC Text"[2] [5])
                {

                }
                Column(CGC_Text__3__1_; "CGC Text"[3] [1])
                {

                }
                Column(CGC_Text__3__2_; "CGC Text"[3] [2])
                {

                }
                Column(CGC_Text__3__4_; "CGC Text"[3] [4])
                {

                }
                Column(CGC_Text__4__1_; "CGC Text"[4] [1])
                {

                }
                Column(CGC_Text__4__2_; "CGC Text"[4] [2])
                {

                }
                Column(CGC_Text__4__3_; "CGC Text"[4] [3])
                {

                }
                Column(CGC_Text__4__4_; "CGC Text"[4] [4])
                {

                }

                Column(FORMAT___Reference_Date___0____Day___Month___Year4____Control1000000024; FORMAT("Reference Date", 0, '<Day>/<Month>/<Year4>'))
                {

                }

                Column(CGC_Text__3__3_; "CGC Text"[3] [3])
                {

                }

                Column(CREDIT_GUARANTEE_CERTIFICATECaption; CREDIT_GUARANTEE_CERTIFICATECaptionLbl)
                {

                }

                Column(Ref__No_Caption; Ref__No_CaptionLbl)
                {

                }


                Column(V1_Caption; V1_CaptionLbl)
                {

                }
                Column(V2_Caption; V2_CaptionLbl)
                {

                }
                Column(V3_Caption; V3_CaptionLbl)
                {

                }
                Column(V4_Caption; V4_CaptionLbl)
                {

                }

                Column(SEALED_with_the_Common_SealCaption; SEALED_with_the_Common_SealCaptionLbl)
                {

                }
                Column(of_the_PASSCaption; of_the_PASSCaptionLbl)
                {

                }
                Column(EmptyStringCaption; EmptyStringCaptionLbl)
                {

                }
                Column(In_our_presence_Caption; In_our_presence_CaptionLbl)
                {

                }
                Column(SIGNATURE_Caption; SIGNATURE_CaptionLbl)
                {

                }
                Column(EmptyStringCaption_Control1102750039; EmptyStringCaption_Control1102750039Lbl)
                {

                }
                Column(NAME_Caption; NAME_CaptionLbl)
                {

                }
                Column(POSTAL_ADDRESS_Caption; POSTAL_ADDRESS_CaptionLbl)
                {

                }
                Column(DESIGNATION_Caption; DESIGNATION_CaptionLbl)
                {

                }
                Column(DATE_Caption; DATE_CaptionLbl)
                {

                }


                Column(SIGNATURE_Caption_Control1000000001; SIGNATURE_Caption_Control1000000001Lbl)
                {

                }
                Column(NAME_Caption_Control1000000002; NAME_Caption_Control1000000002Lbl)
                {

                }
                Column(POSTAL_ADDRESS_Caption_Control1000000003; POSTAL_ADDRESS_Caption_Control1000000003Lbl)
                {

                }
                Column(DESIGNATION_Caption_Control1000000004; DESIGNATION_Caption_Control1000000004Lbl)
                {

                }
                Column(EmptyStringCaption_Control1000000007; EmptyStringCaption_Control1000000007Lbl)
                {

                }

                Column(DATE_Caption_Control1000000025; DATE_Caption_Control1000000025Lbl)
                {

                }
                Column(Signatory1; Signatory1FullName)
                {

                }
                Column(signatory2; Signatory2FullName)
                {

                }


                Column(Signatory1__Address; Signatory1Address)
                {

                }
                Column(Signatory2__Address; Signatory2Address)
                {

                }
                Column(Designation1____; designation1)
                {

                }
                Column(Designation2____; designation2)
                {

                }


                trigger OnAfterGetRecord()

                begin
                    CalcFields("Total Principal Loan");
                    LenderOptionTable.Reset();
                    LenderOptionTable.SETFILTER("Single CGC Seq. No.", FORMAT("Lenders Option Single CGC"."Seq. No."));
                    LenderOptionTable.SetRange("Reference No.", "Lenders Option Single CGC"."Reference No.");
                    IF LenderOptionTable.FIND('-') THEN BEGIN
                        Signatory1 := LenderOptionTable."Signatory 1 (CGC)";
                        Signatory2 := LenderOptionTable."Signatory 2 (CGC)";
                    END;

                    ProffesionalsRec.SETRANGE(Code, Signatory1);
                    IF ProffesionalsRec.FIND('-') THEN BEGIN
                        Signatory1FullName := ProffesionalsRec.Name;
                        Signatory1Address := ProffesionalsRec."Postal Address";
                        designation1 := ProffesionalsRec."Job Title";
                    END;
                    ProffesionalsRec.SETRANGE(Code, Signatory2);
                    IF ProffesionalsRec.FIND('-') THEN BEGIN
                        Signatory2FullName := ProffesionalsRec.Name;
                        Signatory2Address := ProffesionalsRec."Postal Address";
                        designation2 := ProffesionalsRec."Job Title";
                    END;


                    BankRec.SETRANGE("No.", "Lenders Option Single CGC"."Financial Institution Code");
                    IF BankRec.FIND('-') THEN BEGIN
                        LendersOptionBankFullAdd := BankRec.Name + ', ' + BankRec.Address + ', ' + BankRec.City;
                    END;

                    // Bullet 1
                    "CGC Text"[1] [1] := CompInfo.Name + ' (PASS) hereby provide ' + LendersOptionBankFullAdd;
                    "CGC Text"[1] [2] := "CGC Text"[1] [2] + ' with a Credit Guarantee in respect of';
                    "CGC Text"[1] [3] := 'its client by the name of';
                    "CGC Text"[1] [4] := "Lenders Option Single CGC".Description + '';
                    "CGC Text"[1] [5] := '' + '' + 'as per annexed detailed list ';

                    // Bullet 2
                    "CGC Text"[2] [1] := 'The Credit Guarantee is in respect of your letter with reference number ';
                    "CGC Text"[2] [2] := "Lenders Option Single CGC"."Reference No.";
                    "CGC Text"[2] [3] := 'dated';
                    "CGC Text"[2] [4] := STRSUBSTNO('%1', FORMAT("Lenders Option Single CGC"."Reference Date", 0, '<Day> <Month Text> <Year4>'));
                    "CGC Text"[2] [5] := '.'; //signed by the client.

                    // Bullet 3
                    "CGC Text"[3] [1] := 'The total principal loan under (Short term Loan) with the above Reference number is Tanzanian Shillings ';
                    "CGC Text"[3] [2] := STRSUBSTNO('%1/=,', "Lenders Option Single CGC"."Total Principal Loan") + ' say in words (' + AmountInWords("Lenders Option Single CGC"."Total Principal Loan") + ' ONLY)';

                    // Bullet 4
                    "CGC Text"[4] [1] := STRSUBSTNO('The Credit Guarantee covers %1% say in words (', "Lenders Option Single CGC"."Credit Guarantee %") + AmountInWords("Lenders Option Single CGC"."Credit Guarantee %") + ' PERCENT)' + STRSUBSTNO(' of the outstanding');
                    "CGC Text"[4] [2] := AmountInWords("Lenders Option Single CGC"."Credit Guarantee %") + ' PERCENT)';
                    "CGC Text"[4] [3] := STRSUBSTNO('balance of the loan amount and the maximum payable is %1%', "Lenders Option Single CGC"."Credit Guarantee %") + STRSUBSTNO(' of the loan principal');
                    "CGC Text"[4] [4] := STRSUBSTNO(' of the outstanding');
                end;
            }
        }
    }
    var
        SNnumbers: Integer;
        CompInfo: Record "Company Information";

        Currency: Record Currency;
        Signatory1: Text[200];
        Signatory2: Text[200];
        "CGC Text": array[4, 5] of Text[3000];
        FormatAddr: Codeunit "Format Address";
        BankAddr: array[8] of Text[90];
        LenderOptionTable: Record "Guarantee Contracts";
        LendersOptionBankFullAdd: Text[200];
        Signatory1FullName: Text[200];
        Signatory2FullName: Text[200];
        Signatory1Address: Text[200];
        Signatory2Address: Text[200];
        ProffesionalsRec: Record "Salesperson/Purchaser";
        designation1: Text[200];
        designation2: Text[200];
        BankRec: Record Customer;

        CREDIT_GUARANTEE_CERTIFICATECaptionLbl: TextConst ENU = 'CREDIT GUARANTEE CERTIFICATE';
        Ref__No_CaptionLbl: TextConst ENU = 'Ref. No.';
        V1_CaptionLbl: TextConst ENU = '1.';
        V2_CaptionLbl: TextConst ENU = '2.';
        V3_CaptionLbl: TextConst ENU = '3.';
        V4_CaptionLbl: TextConst ENU = '4.';
        SEALED_with_the_Common_SealCaptionLbl: TextConst ENU = 'SEALED with the Common Seal';
        of_the_PASSCaptionLbl: TextConst ENU = 'of the PASS';
        EmptyStringCaptionLbl: TextConst ENU = '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .';
        In_our_presence_CaptionLbl: TextConst ENU = 'In our presence:';
        SIGNATURE_CaptionLbl: TextConst ENU = 'SIGNATURE:';
        EmptyStringCaption_Control1102750039Lbl: TextConst ENU = '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .';
        NAME_CaptionLbl: TextConst ENU = 'NAME:';
        POSTAL_ADDRESS_CaptionLbl: TextConst ENU = 'POSTAL ADDRESS:';
        DESIGNATION_CaptionLbl: TextConst ENU = 'DESIGNATION:';
        DATE_CaptionLbl: TextConst ENU = 'DATE:';
        SIGNATURE_Caption_Control1000000001Lbl: TextConst ENU = 'SIGNATURE:';
        NAME_Caption_Control1000000002Lbl: TextConst ENU = 'NAME:';
        POSTAL_ADDRESS_Caption_Control1000000003Lbl: TextConst ENU = 'POSTAL ADDRESS:';
        DESIGNATION_Caption_Control1000000004Lbl: TextConst ENU = 'DESIGNATION:';
        EmptyStringCaption_Control1000000007Lbl: TextConst ENU = '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .';
        DATE_Caption_Control1000000025Lbl: TextConst ENU = 'DATE:';

    procedure AmountInWords(Amount: Decimal): Text[250]
    var

        CheckReport: Report "Check - Receipt Requirement";
        NumberText: array[2] of Text[80];
    begin
        CheckReport.InitTextVariable;
        CheckReport.CGCFormatNoText(NumberText, Amount);
        EXIT(NumberText[1]);
    end;
}