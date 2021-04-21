page 51513366 "Medical scheme Header"
{
    // version HR

    PageType = Card;
    SourceTable = "Medical Scheme Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No.";"No.")
                {
                    Editable = false;
                }
                field("Selection Date";"Selection Date")
                {
                }
                field("Cover Type";"Cover Type")
                {

                    trigger OnValidate();
                    begin
                        if "Cover Type"=1
                            then begin
                          "Service Provider":='ERC';
                           "Name of Broker":='Liason Brokers'
                           end;

                        if "Cover Type"=2
                            then begin
                          "Service Provider":='UAP';
                           "Name of Broker":='Liason Brokers'
                           end;
                    end;
                }
                field("Service Provider";"Service Provider")
                {
                    Editable = false;
                }
                field("Name of Broker";"Name of Broker")
                {
                    Editable = false;
                }
                field("Policy No";"Policy No")
                {
                    Enabled = false;
                }
                field("Policy Start Date";"Policy Start Date")
                {
                }
                field("Policy Expiry Date";"Policy Expiry Date")
                {
                }
                field("Employee No";"Employee No")
                {
                    Editable = true;
                }
                field("Employee Name";"Employee Name")
                {
                    Editable = false;
                }
                field("Entitlement -Inpatient";"Entitlement -Inpatient")
                {
                    Editable = false;
                }
                field("Entitlement -OutPatient";"Entitlement -OutPatient")
                {
                    Editable = false;
                }
                field("Fiscal Year";"Fiscal Year")
                {
                }
                field("No. Of Lives";"No. Of Lives")
                {
                    Caption = 'No. of dependants';
                }
                field("Cover Selected";"Cover Selected")
                {
                }
                field("In-Patient Claims";"In-Patient Claims")
                {
                    Enabled = false;
                    Visible = false;
                }
                field("Out-Patient Claims";"Out-Patient Claims")
                {
                    Enabled = false;
                    Visible = false;
                }
            }
            part(Control1000000030;"Medical Dependants")
            {
                SubPageLink = "Medical Scheme No"=FIELD("No."),
                              "Employee Code"=FIELD("Employee No");
            }
        }
    }

    actions
    {
    }

    trigger OnInit();
    begin
        /*
        IF usersetup.GET(USERID) THEN BEGIN
        empl.GET(usersetup."Employee No.");
        IF empl."Posting Group"='TEMP'  THEN
        ERROR('Contract staff are not allowed to do medical scheme selection');
        IF empl."Posting Group"='INTERN'  THEN
        ERROR('Contract staff are not allowed to do medical scheme selection');
                        END
        */

    end;

    trigger OnInsertRecord(BelowxRec : Boolean) : Boolean;
    begin
        "Employee No":= usersetup."Employee No.";
         INSERT;
         VALIDATE("Employee No");
    end;

    trigger OnOpenPage();
    begin
        if usersetup.GET(USERID) then
           begin
               SETRANGE("Employee No",usersetup."Employee No.");


        end;
    end;

    var
        usersetup : Record "User Setup";
        empl : Record Employee;
}

