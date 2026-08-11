using HelpdeskService as service from '../../srv/helpdesk-service';
annotate service.Tickets with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Ticket',
                Value : ticketNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Subject',
                Value : subject,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Description',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Status',
                Value : status,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Priority',
                Value : priority,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Ticket Comments',
            ID : 'TicketComments',
            Target : 'comments/@UI.LineItem#TicketComments',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Ticket Number',
            Value : ticketNumber,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Subject',
            Value : subject,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : description,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Priority',
            Value : priority,
        },
        {
            $Type : 'UI.DataField',
            Value : assignee.name,
            Label : 'Assignee',
        },
    ],
    UI.HeaderInfo: {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Ticket',
        TypeNamePlural : 'Tickets',
        Title : {
            $Type : 'UI.DataField',
            Value : ticketNumber,
            Label : 'Ticket Number',
        },
    },
    UI.SelectionFields: [
        assignee.name,
        subject,
        status,
        priority
    ]
);

annotate service.Tickets with {
    ticketNumber @Common.Label: 'Ticket Number';
    subject @Common.Label: 'Subject';
    description @Common.Label: 'Description';
    status @(
        Common.Label: 'Status',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Tickets',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status,
                    ValueListProperty : 'status',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    );
    priority @(
        Common.Label: 'Priority',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Tickets',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : priority,
                    ValueListProperty : 'priority',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    );
    category @Common.Label: 'Category';
    assignee @Common.Label: 'Assignee';
    comments @Common.Label: 'Comments';
};

annotate service.Agents with {
    name @(
        Common.Label: 'Assignee',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Agents',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : name,
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'email',
                },
            ],
            Label : 'Assignee',
        },
        Common.ValueListWithFixedValues : false,
    )
};


annotate service.Tickets with {
    category @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Categories',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : category_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
        ],
    }
};

annotate service.Tickets with {
    assignee @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Agents',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : assignee_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'email',
            },
        ],
    }
};

annotate service.Comments with @(
    UI.LineItem #TicketComments : [
        {
            $Type : 'UI.DataField',
            Value : ticket.ticketNumber,
            Label : 'Ticket',
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
            Label : 'Created At',
        },
        {
            $Type : 'UI.DataField',
            Value : text,
            Label : 'Comment',
        },
    ]
);

