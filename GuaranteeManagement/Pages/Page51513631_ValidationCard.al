page 51513631 "Validation Card"
{
    PageType = Card;
    SourceTable = "Validation Table";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field(Banks; Banks)
                {

                }
                field("Bank Name"; "Bank Name")
                {

                }
                field(Quarter; Quarter)
                {

                }
                field("Validate Contract No."; "Validate Contract No.")
                {

                }
                field("Validate Names"; "Validate Names")
                {

                }
                field("Split Number"; "Split Number")
                {

                }
                field("Validate Loan No"; "Validate Loan No")
                {

                }
                field("Total Entries"; "Total Entries")
                {

                }
                field("Validated Entries"; "Validated Entries")
                {

                }
                field("Repeated Entries"; "Repeated Entries")
                {

                }

            }
            part(Lines; "Validation Lines")
            {
                SubPageLink = "Header No" = field ("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import from Excel")
            {
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();

                var
                    importport: XmlPort "Aging Report New";
                begin
                    importport.Run();
                end;
            }
            action(Validate)
            {
                ApplicationArea = All;
                Image = Check;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    TotalCount := 0;
                    Percentage := 0;
                    Counter := 0;

                    Header.Reset();
                    Header.SetRange("No.", Rec."No.");
                    if Header.Find('-') then begin
                        Lines.Reset();
                        Lines.SetRange("Header No", Header."No.");
                        if Lines.FindSet() then
                            repeat
                                //Lines."Contract Number" := '';
                                Lines.Validated := false;
                                Lines."Repeated Entry" := false;
                                Lines.Modify();
                            until Lines.Next() = 0;

                        //***********************Mark repeated entries
                        FnMarkRepeatedEntries(Header."No.");

                        Window.OPEN(FORMAT('Validating Lines') + ': @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
                        TotalCount := Lines.COUNT;

                        Lines.Reset();
                        Lines.SetRange("Header No", Header."No.");
                        Lines.SetRange("Repeated Entry", false);
                        if Lines.FindSet() then
                            repeat
                                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                                Counter := Counter + 1;
                                Window.UPDATE(1, Percentage);
                                Window.UPDATE(2, Counter);

                                GuarContracts.Reset();
                                GuarContracts.SetRange("Loan No.", Lines."Account No.");
                                if GuarContracts.Find('-') then begin
                                    Lines."Contract No." := GuarContracts."No.";
                                    Lines."Product Type" := GuarContracts.Product;
                                    Lines."Global Dimension 1 Code" := GuarContracts."Global Dimension 1 Code";
                                    Lines."Global Dimension 2 Code" := GuarContracts."Global Dimension 2 Code";
                                    Lines.Validated := true;
                                    Lines.Modify();
                                end;


                            until Lines.Next() = 0;


                        if Header."Validate Contract No." then begin

                            Lines.Reset();
                            Lines.SetRange("Header No", Header."No.");
                            Lines.SetRange(Validated, false);
                            Lines.SetRange("Repeated Entry", false);
                            TotalCount += Lines.COUNT;
                            if Lines.FindSet() then
                                repeat
                                    Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                                    Counter := Counter + 1;
                                    Window.UPDATE(1, Percentage);
                                    Window.UPDATE(2, Counter);

                                    GuarContracts.Reset();
                                    GuarContracts.SetRange("No.", Lines."Contract No.");
                                    if GuarContracts.Find('-') then begin
                                        Lines."Contract No." := GuarContracts."No.";
                                        Lines."Product Type" := GuarContracts.Product;
                                        Lines."Global Dimension 1 Code" := GuarContracts."Global Dimension 1 Code";
                                        Lines."Global Dimension 2 Code" := GuarContracts."Global Dimension 2 Code";
                                        Lines.Validated := true;
                                        Lines.Modify();
                                    end;

                                until Lines.Next() = 0;


                        end;
                        if Header."Validate Names" then begin

                            Lines.Reset();
                            Lines.SetRange("Header No", Header."No.");
                            Lines.SetRange(Validated, false);
                            Lines.SetRange("Repeated Entry", false);
                            TotalCount += Lines.COUNT;
                            if Lines.FindSet() then
                                repeat
                                    Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                                    Counter := Counter + 1;
                                    Window.UPDATE(1, Percentage);
                                    Window.UPDATE(2, Counter);

                                    GuarContracts.Reset();
                                    GuarContracts.SetRange(Name, Lines."Customer Name");
                                    if GuarContracts.Find('-') then begin
                                        Lines."Contract No." := GuarContracts."No.";
                                        Lines."Product Type" := GuarContracts.Product;
                                        Lines."Global Dimension 1 Code" := GuarContracts."Global Dimension 1 Code";
                                        Lines."Global Dimension 2 Code" := GuarContracts."Global Dimension 2 Code";
                                        Lines.Validated := true;
                                        Lines.Modify();
                                    end;

                                until Lines.Next() = 0;


                        end;
                        if Header."Validate Loan No" then begin

                            Lines.Reset();
                            Lines.SetRange("Header No", Header."No.");
                            Lines.SetRange(Validated, false);
                            Lines.SetRange("Repeated Entry", false);
                            TotalCount += Lines.COUNT;
                            if Lines.FindSet() then
                                repeat
                                    Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                                    Counter := Counter + 1;
                                    Window.UPDATE(1, Percentage);
                                    Window.UPDATE(2, Counter);

                                    GuarContracts.Reset();
                                    GuarContracts.SetRange("Loan No.", Lines."Loan No");
                                    if GuarContracts.Find('-') then begin
                                        Lines."Contract No." := GuarContracts."No.";
                                        Lines."Product Type" := GuarContracts.Product;
                                        Lines."Global Dimension 1 Code" := GuarContracts."Global Dimension 1 Code";
                                        Lines."Global Dimension 2 Code" := GuarContracts."Global Dimension 2 Code";
                                        Lines.Validated := true;
                                        Lines.Modify();
                                    end;

                                until Lines.Next() = 0;


                        end;
                        if Header."Split Number" then begin

                            Lines.Reset();
                            Lines.SetRange("Header No", Header."No.");
                            Lines.SetRange(Validated, false);
                            Lines.SetRange("Repeated Entry", false);
                            TotalCount += Lines.COUNT;
                            if Lines.FindSet() then
                                repeat
                                    Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                                    Counter := Counter + 1;
                                    Window.UPDATE(1, Percentage);
                                    Window.UPDATE(2, Counter);

                                    ReferenceNo := CopyStr(Lines."Contract No.", 5, 7);
                                    Message(Format(DELCHR(ReferenceNo, '<', '0')));

                                    GuarContracts.Reset();
                                    GuarContracts.SetRange("Loan No.", DELCHR(ReferenceNo, '<', '0'));
                                    if GuarContracts.Find('-') then begin
                                        Lines."Contract No." := GuarContracts."No.";
                                        Lines."Product Type" := GuarContracts.Product;
                                        Lines."Global Dimension 1 Code" := GuarContracts."Global Dimension 1 Code";
                                        Lines."Global Dimension 2 Code" := GuarContracts."Global Dimension 2 Code";
                                        Lines.Validated := true;
                                        Lines.Modify();
                                    end;

                                until Lines.Next() = 0;

                        end;



                        Message('Validation Complete');
                        Window.Close();

                    end;


                end;
            }
            action("Transfer To Loan Entries")
            {
                ApplicationArea = All;
                Image = PostBatch;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    TotalCount := 0;
                    Percentage := 0;
                    Counter := 0;

                    Header.Reset();
                    Header.SetRange("No.", Rec."No.");
                    if Header.Find('-') then begin

                        Lines.Reset();
                        Lines.SetRange("Header No", Header."No.");
                        Lines.SetRange(Validated, true);
                        if Lines.FindSet() then begin
                            Window.OPEN(FORMAT('Transfering Lines') + ': @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
                            TotalCount := Lines.COUNT;

                            repeat
                                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                                Counter := Counter + 1;
                                Window.UPDATE(1, Percentage);
                                Window.UPDATE(2, Counter);

                                with LoanEntries do begin
                                    "Contract No." := Lines."Contract No.";
                                    "Loan No" := Lines."Loan No";
                                    "Customer Name" := Lines."Customer Name";
                                    "Account No." := Lines."Account No.";
                                    "Approved Amount" := Lines."Approved Amount";
                                    "Disbursed Amount" := Lines."Disbursed Amount";
                                    "Outstanding Principal Amt" := Lines."Outstanding Principal Amt";
                                    "Repayment Installment Amt" := Lines."Repayment Installment Amt";
                                    "Total Exposure" := Lines."Total Exposure";
                                    "Total Principal Amt Paid" := Lines."Total Principal Amt Paid ";
                                    "Interest Amt Accrued" := Lines."Interest Amt Accrued";
                                    "Principal Amt In Arrears" := Lines."Principal Amt In Arrears";
                                    "Interest Amt In Arrears" := Lines."Interest Amt In Arrears";
                                    "Total No. of Installments" := Lines."Total No. of Installments";
                                    "No. of Installments In Arrears" := Lines."No. of Installments In Arrears";
                                    Guarantee := Lines.Guarantee;
                                    "Guarantee Amt" := Lines."Guarantee Amt";
                                    "System Classification" := Lines."System Classification";
                                    "Loan Disbursed Date" := Lines."Loan Disbursed Date";
                                    "Loan Maturity Date" := Lines."Loan Maturity Date";
                                    "Days Past Due" := Lines."Days Past Due";
                                    "Reporting Date" := Lines."Reporting Date";
                                    "Global Dimension 1 Code" := Lines."Global Dimension 1 Code";
                                    "Global Dimension 2 Code" := Lines."Global Dimension 2 Code";
                                    "Bank Brach Name" := Lines."Bank Brach Name";
                                    Bank := Header.Banks;
                                    "Loan Value Date" := Lines."Loan Value Date";
                                    "Date Imported" := Today;
                                    "Time Imported" := Time;
                                    "Imported By" := UserId;
                                    Bank := Header.Banks;
                                    "Risk Sharing Fee" := Lines."Risk Sharing Fee";

                                    Insert(true);

                                end;
                                GuarContracts.Reset();
                                GuarContracts.SetRange("No.", Lines."Contract No.");
                                if GuarContracts.Find('-') then begin

                                    GuarContracts."Loan No." := Lines."Loan No";

                                    if GuarContracts."Receivables Acc. No." <> Header.Banks then begin
                                        GuarContracts."Receivables Acc. No." := Header.Banks;
                                        //GuarContracts.Validate("Receivables Acc. No.");
                                    end;



                                    if Lines."Global Dimension 1 Code" <> '' then begin
                                        if GuarContracts."Global Dimension 1 Code" = '' then
                                            GuarContracts."Global Dimension 1 Code" := Lines."Global Dimension 1 Code";
                                    end;
                                    if Lines."Global Dimension 2 Code" <> '' then begin
                                        if GuarContracts."Global Dimension 2 Code" = '' then
                                            GuarContracts."Global Dimension 2 Code" := Lines."Global Dimension 2 Code";
                                    end;
                                    if GuarContracts."Loan Issued Date" = 0D then
                                        GuarContracts."Loan Issued Date" := Lines."Loan Value Date";

                                    if GuarContracts."Loan Maturity Date" = 0D then
                                        GuarContracts."Loan Maturity Date" := Lines."Loan Maturity Date";

                                    /*with LOBEntries do begin
                                        "Client No." := Lines."Contract Number";
                                        Subsector := Lines."Sub Sector";
                                        "Line of Business" := Lines."Business Type";
                                        "Farm Size" := Lines."Farm Size";
                                        Technology := Lines.Technology;
                                        "Technology Type" := Lines."Technology Type";
                                        Type := Lines."Crop Type";
                                        "No. of Animals" := Lines."No Of Animals";
                                        Insert(true);
                                    end;*/


                                    GuarContracts.Modify(true);

                                end;
                            until Lines.Next() = 0;

                            Message('Transfer Complete');
                            Window.Close();
                        end;


                    end;


                end;
            }




        }
    }
    local procedure FnMarkRepeatedEntries(var DocNo: Code[20])
    var
        ObjLines: Record "Validation Lines";
    begin
        ObjLines.Reset();
        ObjLines.SetCurrentKey("Contract No.", "Loan No");
        ObjLines.SetRange("Header No", DocNo);
        ObjLines.SetRange("Contract No.", ObjLines."Contract No.");
        ObjLines.SetRange("Repeated Entry", false);
        if ObjLines.FindSet() then
            repeat
                LinesCount := ObjLines.Count;
                Error(Format(LinesCount));

                if LinesCount > 1 then begin
                    Error(Format(LinesCount));
                    Lines1.Reset();
                    Lines1.SetRange("Header No", ObjLines."Header No");
                    Lines1.SetRange("Contract No.", ObjLines."Contract No.");
                    if Lines1.findset() then
                        repeat
                            Lines1."Repeated Entry" := true;
                            Lines1.Modify();
                        until Lines1.Next() = 0;
                end;
            until ObjLines.Next() = 0;


    end;

    var
        myInt: Integer;
        Header: Record "Validation Table";
        Lines: Record "Validation Lines";
        GuarContracts: Record "Guarantee Contracts";
        Window: Dialog;
        TotalCount: Integer;
        Percentage: Decimal;
        Counter: Integer;
        LoanEntries: Record "Loan Account Entries";
        ReferenceNo: Code[20];
        LOBEntries: Record "Subsector & Line of Business";
        GuaranteeMng: Codeunit "Guarantee Management";
        LinesCount: Integer;
        Lines1: Record "Validation Lines";


}