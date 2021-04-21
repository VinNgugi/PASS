codeunit 51513004 "Page Management Ext"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalCardPageID(RecordRef)
    end;

    local procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer
    begin
        CASE RecordRef.Number of
            DATABASE::"Guarantee Application":
                exit(Page::"Guarantee Application Card");
            Database::"Guarantee Contracts":
                exit(Page::"CGC Preparation Card");
            Database::"Fee Waiver Application":
                exit(Page::"Fee Waiver Application");
            Database::"Lenders Option Journal Header":
                exit(Page::"LO General Journal Header");
            Database::"Restructuring Memo Header":
                exit(Page::"Restructuring Memo");
            Database::"Change Request":
                exit(Page::"Change Request Card")
        end;


    end;
}