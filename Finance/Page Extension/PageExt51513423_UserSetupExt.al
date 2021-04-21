pageextension 51513423 "User Setup Ext_2" extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast(Creation)
        {
            action("Create Imprest A/C")
            {
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Customer: Record Customer;
                    ImpSetup: Record "Cash Management Setup";
                    Emp: Record Employee;
                    EmpName: Text[100];
                begin


                    IF Customer.GET("Employee No.") OR Customer.GET("Imprest Account") THEN
                        ERROR('Employee No %1 already exists in the customer table', "Employee No.")
                    ELSE BEGIN
                        ImpSetup.GET;
                        ImpSetup.TESTFIELD("Imprest Posting Group");
                        ImpSetup.TESTFIELD("General Bus. Posting Group");
                        ImpSetup.TESTFIELD("VAT Bus. Posting Group");
                        IF Emp.GET("Employee No.") THEN
                            EmpName := COPYSTR(Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name", 1, 50);
                        Customer.INIT;
                        Customer."No." := "Employee No.";
                        //Customer."Customer Type" := Customer."Customer Type"::Imprest;
                        Customer.Name := EmpName;
                        Customer."Customer Posting Group" := ImpSetup."Imprest Posting Group";
                        Customer."Gen. Bus. Posting Group" := ImpSetup."General Bus. Posting Group";
                        Customer."VAT Bus. Posting Group" := ImpSetup."VAT Bus. Posting Group";
                        IF NOT Customer.GET("Employee No.") THEN
                            Customer.INSERT;
                        MESSAGE('Employee No %1 has been created successfully added to the customer table', "Employee No.");
                        IF Customer.Get("Employee No.") then begin
                            "Imprest Account" := "Employee No.";
                            modify;
                        end;
                    END;
                end;
            }
        }
    }
    var
        myInt: Integer;
}