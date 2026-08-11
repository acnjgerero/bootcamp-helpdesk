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
                Criticality : statusCriticality,
                CriticalityRepresentation : #WithIcon,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Priority',
                Value : priority,
                Criticality : priorityCriticality,
                CriticalityRepresentation : #WithoutIcon,
            },
            {
                $Type : 'UI.DataField',
                Value : assignee_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : category_ID,
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
            Criticality : statusCriticality,
            CriticalityRepresentation : #WithIcon,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Priority',
            Value : priority,
            Criticality : priorityCriticality,
            CriticalityRepresentation : #WithoutIcon,
        },
        {
            $Type : 'UI.DataField',
            Value : assignee.name,
            Label : 'Assignee',
        },
        {
            $Type : 'UI.DataField',
            Value : category.name,
            Label : 'Category',
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
        status,
        priority,
        category.name,
    ],
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'HelpdeskService.closeTicket',
            Label : 'Close Ticket',
        },
    ],
);

annotate service.Tickets with {
    ticketNumber @Common.Label: 'Ticket Number';
    subject @Common.Label: 'Subject';
    description @Common.Label: 'Description';
    status @(
        Common.Label: 'Status',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Statuses',
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
            CollectionPath : 'Priorities',
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
    category @(
        Common.ValueList : {
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
        },
        Common.Text: category.name,
        Common.TextArrangement: #TextOnly
    )
};

annotate service.Tickets with {
    assignee @(
        Common.ValueList : {
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
        },
        Common.Text: assignee.name,
        Common.TextArrangement: #TextOnly
    )
};

annotate service.Comments with @(
    UI.LineItem #TicketComments : [
        {
            $Type : 'UI.DataField',
            Value : ticket.ticketNumber,
            Label : 'Ticket',
            @UI.Hidden,
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

annotate service.Categories with {
    name @(
        Common.Label : 'Category',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Categories',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : name,
                    ValueListProperty : 'name',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};

