page 51513442 "HR Career Event Option Box"
{
    // version HR

    PageType = Card;

    layout
    {
        area(content)
        {
            field(MessageTextBox; '')
            {
                CaptionClass = FORMAT(MessageText);
                MultiLine = true;
            }
            field(ReasonText; ReasonText)
            {
                Caption = 'Reason';
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        if CloseAction = ACTION::No then
            NoOnPush;
        if CloseAction = ACTION::Yes then
            YesOnPush;
    end;

    var
        MessageText: Text[250];
        ResultEvent: Boolean;
        ReasonText: Text[100];
        CareerHistory: Record "HR Career History";
        ResultReason: Text[100];

    procedure SetMessage(Message: Text[200]);
    begin
        MessageText := 'Do you wish to create a career event, called %1 ?';
        MessageText := STRSUBSTNO(MessageText, Message);
    end;

    procedure ReturnResult() Result: Boolean;
    begin
        Result := ResultEvent;
    end;

    procedure ReturnReason() ReturnReason: Text[100];
    begin
        ReturnReason := ReasonText;
    end;

    local procedure YesOnPush();
    begin
        ResultEvent := true;
    end;

    local procedure NoOnPush();
    begin
        ResultEvent := false;
    end;
}

