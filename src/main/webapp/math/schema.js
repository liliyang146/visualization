{
    types: {
        'Dance': {
            pluralLabel: 'Dances'
        },
        'Video': {
	    pluralLabel: 'Videos'
		}
    },
    properties: {
//dance properties
	'label': {
	    label: "dance name",
		pluralLabel: "dance names"
	},
	    'update': {
		valueType: "item"
		    },
        'form': {
            valueType: "text"
//          intended values: circle/couple/line/mixer (multi)
        },
	    'hebrewName': {
		label: "Hebrew Name",
		    pluralLabel: "Hebrew Names"
	    },
        'choreographer': {
            valueType: "text",
            pluralLabel: "choreographers",
            reverseLabel: "choreographed",
            reversePluralLabel: "choreographed"
        },
        'submitDate': {
	    label: "date submitted",
	    valueType: "date",
            pluralLabel: "dates submitted"
	},
        'year': {
            label: 'year choreographed',
            valueType: "date",
            pluralLabel: "years choreographed"
        },
        'comment': {
            valueType: "text",
            pluralLabel: "comments"
        },
//video properties
        'thumbnail': {
            valueType: "url"
        },
//        'dance': {
//            valueType: "item"
//        },
        'subjects': {
            valueType: "item",
            label: "performers" ,
            pluralLabel: "performers"
//          intended values: open session or open session with leader 
//                           or small group or solo or performance
        },
        'lesson': {
            valueType: "text",   //  Yes/No
            label: "includes lesson"
        },
        'withChoreographer': {
            valueType: "text",   //  Yes/No/Unknown
            label: "with choreographer"
        },
        'vurl': {
            valueType: "url",
            label: "video link"
        },
	    'site': {
		valueType: "item"
	    },
        'quality': {
            valueType: "item",
            label: "video quality",
            pluralLabel: "video qualities"
         },
	'musicPerformer': {
	    label: "musician",
		pluralLabel: "musicians"   
		},
         'loc': {
            valueType: "text",
            label: "location",
            pluralLabel: "locations"
         },
         'tempo': {
            valueType: "number",
            label: "tempo",
            pluralLabel: "tempos"
         },
         'speed': {
            valueType: "text",
            label: "speed",
            pluralLabel: "speeds"
         },
         'vyear': {
            label: "year recorded",
            valueType: "date"
         },
         'hasVenue': {
            label: "has Venue information",
            valueType: "boolean"
 	 }
    }
}