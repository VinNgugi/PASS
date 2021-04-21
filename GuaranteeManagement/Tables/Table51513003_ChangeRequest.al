table 51513003 "Change Request"
{
    Caption = 'Change Request';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request No"; Code[20])
        {
            Caption = 'Request No';
            Editable = False;
            DataClassification = ToBeClassified;
        }
        field(2; "Requested Date"; Date)
        {
            Caption = 'Requested Date';
            Editable = False;
            DataClassification = ToBeClassified;
        }
        field(3; "Requested Time"; Time)
        {
            Caption = 'Requested Time';
            Editable = False;
            DataClassification = ToBeClassified;
        }
        field(4; "Created By"; Code[20])
        {
            Caption = 'Created By';
            Editable = False;
            DataClassification = ToBeClassified;
        }
        field(5; "Client No"; Code[20])
        {
            Caption = 'Client No';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where("Customer Posting Group" = const('CLIENTS'));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ObjCustomer.Get("Client No") then
                    "Client Name" := ObjCustomer.Name
                else
                    "Client Name" := '';
            end;
        }
        field(6; "Client Name"; Text[50])
        {
            Caption = 'Client Name';
            Editable = False;
            DataClassification = ToBeClassified;
        }
        field(7; "Contract No"; Code[20])
        {
            Caption = 'Contract No';
            DataClassification = ToBeClassified;
            TableRelation = "Guarantee Application"."No." where("Customer No." = field("Client No"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ObjGuarrApp.Get("Contract No") then begin
                    "Product Type" := ObjGuarrApp.Product;
                end;
            end;
        }
        field(8; "Change Type"; Option)
        {
            Caption = 'Change Type';
            OptionMembers = " ","Product Type Change";
            DataClassification = ToBeClassified;
        }
        field(9; "Product Type"; Code[20])
        {
            Caption = 'Product Type';
            Editable = False;
            DataClassification = ToBeClassified;
        }
        field(10; Type; Option)
        {
            Editable = false;
            DataClassification = CustomerContent;
            OptionMembers = " ",Traditional,"Lenders Option";

        }
        field(11; "New Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Traditional,"Lenders Option";

        }
        field(12; "New Product type"; Code[20])
        {
            Caption = 'New Product type';
            DataClassification = ToBeClassified;
            TableRelation = Products.Code where(Type = field("New Type"));

            trigger OnValidate()
            var
                ProductRec: Record Products;
            begin
                if ProductRec.Get("New Product type") then begin

                    if "New Type" = "New Type"::"Lenders Option" then
                        ProductRec.TestField("Portfolio Guarantee %");

                    //Validate("Receivables Acc. No.");
                    //Validate("Loan Amount");
                    //Validate("Currency Code");
                end;

            end;
        }
        field(13; "No. Series"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;

        }
        field(14; "Last modified Date"; Date)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(15; "Last Modified Time"; Time)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(16; "Last Modified By"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(17; "Reason for Change"; Text[250])
        {

        }
        field(18; "Approval Status"; Option)
        {
            Editable = false;
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
    }
    keys
    {
        key(PK; "Request No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        IF "Request No" = '' THEN begin
            GuaranteeSetup.Get;
            GuaranteeSetup.TestField("Change Request No");
            NoSeriesMgt.InitSeries(GuaranteeSetup."Change Request No", xRec."No. Series", 0D, "Request No", "No. Series");
        end;
        "Requested Date" := Today;
        "Requested Time" := Time;
        "Created By" := UserId;
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin

    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        "Last modified Date" := Today;
        "Last Modified Time" := Time;
        "Last Modified By" := UserId;
    end;

    procedure FnProcessChanges(ContractNo: Code[20])
    var
        myInt: Integer;
    begin
        if ObjGuarrApp.Get(ContractNo) then begin
            ObjGuarrApp."Product Type" := "New Type";
            ObjGuarrApp.Product := "Product Type";
            ObjGuarrApp.Validate("Receivables Acc. No.");
            ObjGuarrApp.Validate("Loan Amount");
            ObjGuarrApp.Validate("Currency Code");
            ObjGuarrApp.Modify(true);
        end;
    end;


    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GuaranteeSetup: Record "Guarantee Management Setup";
        ObjCustomer: Record Customer;
        ObjGuarrApp: Record "Guarantee Application";

}
