page 51513213 "Deduction Import"
{
    PageType = Card;
    SourceTable = "Import Deductions";
    caption = 'Deduction Import';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                    Editable = false;
                }
                field("Deduction Code"; "Deduction Code")
                {
                }
                field(Description; Description)
                {
                }
                field("Payroll Period"; "Payroll Period")
                {
                }
                field("Deduction Added"; "Deduction Added")
                {
                }
            }
            part(Control10; "Deduction Lines")
            {
                SubPageLink = Code = FIELD (Code);
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {

            action("Import Deductions")
            {
                Caption = 'Import Deductions';

                trigger OnAction();
                begin
                    Importer.GetRec(Rec);
                    Importer.RUN;
                end;
            }
            action("Transfer To Payroll")
            {
                Caption = 'Transfer To Payroll';

                trigger OnAction();
                begin
                    if "Deduction Added" = false then begin
                        Lines.RESET;
                        Lines.SETRANGE(Code, Rec.Code);
                        if Lines.FIND('-') then begin
                            repeat
                                if Emp.GET(Lines."Employee No") then begin
                                    if Emp.Status = Emp.Status::Active then begin

                                        Assig.RESET;
                                        Assig.SETRANGE("Employee No", Lines."Employee No");
                                        Assig.SETRANGE(Type, Assig.Type::Deduction);
                                        Assig.SETRANGE("Payroll Period", Rec."Payroll Period");
                                        Assig.SETRANGE(Code, Rec."Deduction Code");
                                        if Assig.FIND('-') then begin
                                            Assig.Amount := Lines.Amount;
                                            Assig.MODIFY;

                                        end else begin
                                            AssMatrix.INIT;
                                            AssMatrix."Employee No" := Lines."Employee No";
                                            AssMatrix.VALIDATE("Employee No");
                                            AssMatrix.Type := AssMatrix.Type::Deduction;
                                            AssMatrix.Code := Lines.Deduction;
                                            AssMatrix.VALIDATE(Code);
                                            AssMatrix.Amount := Lines.Amount;
                                            AssMatrix.VALIDATE(Amount);
                                            AssMatrix.INSERT;
                                        end;
                                        Lines.Transfered := true;
                                        Lines.MODIFY;

                                    end;
                                end;
                            until Lines.NEXT = 0;
                            MESSAGE('Process complete! Transactions have been transfered to payroll.');
                        end;

                    end;
                end;
            }
        }
    }

    var
        Importer: XMLport "Import Deductions";
        Assig: Record "Assignment Matrix";
        Lines: Record "Deduction Lines";
        AssMatrix: Record "Assignment Matrix";
        Emp: Record Employee;
}

