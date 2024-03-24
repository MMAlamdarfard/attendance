var jsondata={
    "Name" : "مهدی",
    "LastName": "علمدار فرد",
    "UniqCode": "xyz",
    "StudentCode": "9921010051",
    "Field":"مهندسی برق" ,
    "Tendency":"کنترل",
    //تاریخ امروز رو نشان میدهد
    "today":{
      "year":"1402",
      "month":"9",
      "day":"12",
      "time":"15:10"
    },
    //تمام کلاس ها مثل یک ابجکت  از لیست برگردانده میشود
    "classResult":[
      {
        //روز برقراری کلاس ها مانند 12آذر1402
        "year":"1402",
        "month":"9",
        "day":"12",
        //
        //کلاس های ان روز
        "classes":[  
          {
          "color":"#F44336", 
          "class": "اصول سیستم‌های مخابراتی", 
          "maestro":"محسن حجازی", 
          //این فیلد اضاف است فعلا نیازی به ان نیست
          "type":"1", 
          //
          "start":"14:00",
          "end":"15:30",
          "apartment":"ساختمان ساتر", 
          "class_location":"کلاس22",
          //این ابجکت فقط تعداد دانشجویان کلاس و 4 تا از پروفایل انها را برمیگرداند
          "students":{
              //url اصلی
              "base_url":"assets/avatars/",
              //تعداد دانشجویان ان کلاس
              "count":"30", 
              //عکس پروفایل انها
              "data": [
                 {
                  "avatar":"21.png"     
                 },
                 {
                  "avatar":"22.png"     
                 },
                 {
                  "avatar":"23.png"     
                },
                {
                 "avatar":"24.png"     
                }
              ]}
          },
          //تمام داده های دیگر مثل بالا می باشد
          //یه تایپ isholiday هم برای روز کلاس ها تعریف شده که ان روز تعطیل است یا خیر که باید در مورد ان بحث کنیم
          {

            "class": "تحلیل سیستم‌های انرژی الکتریکی 1", 
           "maestro":"علی کریمی", 
      "type":"1", 
      "start":"16:00",
      "end":"17:30",
      "apartment":"ساختمان ساتر", 
      "class_location":"کلاس16",
          "students":{
          "base_url":"assets/avatars/",
          "count":"6", 
          "data": [
             {
              "avatar":"41.png"     
             },
             {
              "avatar":"42.png"     
             },
             {
              "avatar":"43.png"     
            },
            {
             "avatar":"44.png"     
            }
          ]}
          },
          {
               "class": "سیستم‌های کنترل مدرن", 
               "maestro":"سید حسین اجتهد", 
               "type":"1", 
               "start":"8:00",
               "end":"9:30",
               "apartment":"ساختمان ساتر", 
               "class_location":"کلاس 21",
                   "students":{
                   "base_url":"assets/avatars/",
                   "count":"24", 
                   "data": [
                      {
                       "avatar":"51.png"     
                      },
                      {
                       "avatar":"52.png"     
                      },
                      {
                       "avatar":"53.png"     
                     },
                     {
                      "avatar":"54.png"     
                     }
                   ]}
          },
          {
              "class": "مباحث ویژه", 
              "maestro":"مجید حاجتی پور", 
              "type":"1", 
              "start":"12:30",
              "end":"14:00",
              "apartment":"ساختمان اسلامی", 
              "class_location":"کلاس 128",
              "students":{
                  "base_url":"assets/avatars/",
                  "count":"23", 
                  "data": [
                     {
                      "avatar":"61.png"     
                     },
                     {
                      "avatar":"62.png"     
                     },
                     {
                      "avatar":"63.png"     
                     },
                     {
                      "avatar":"64.png"     
                     }
              ]}
          }  
        
         ]
      },
      {
      "year":"1402",
      "month":"9",
      "day":"11",
      "classes":[
        {
             "color":"#03A9F4",
             "class": "الکترونیک صنعتی", 
             "maestro":"محسن رحیمی", 
             "type":"1", 
             "start":"10:00",
             "end":"11:30",
             "apartment":"ساختمان ساتر", 
             "class_location":"کلاس 13",
                 "students":{
                 "base_url":"assets/avatars/",
                 "count":"10", 
                 "data": [
                    {
                     "avatar":"11.png"     
                    },
                    {
                     "avatar":"12.png"     
                    },
                    {
                     "avatar":"13.png"     
                   },
                   {
                    "avatar":"14.png"     
                   }
                 ]}
        },
        {
            "class": "آمار و احتمالات مهندسی", 
            "maestro":"مهدی سلمان پور", 
            "type":"1", 
            "start":"14:00",
            "end":"15:30",
            "apartment":"ساختمان اسلامی", 
            "class_location":"کلاس 128",
            "students":{
                "base_url":"assets/avatars/",
                "count":"30", 
                "data": [
                   {
                    "avatar":"21.png"     
                   },
                   {
                    "avatar":"22.png"     
                   },
                   {
                    "avatar":"23.png"     
                  },
                  {
                   "avatar":"24.png"     
                  }
            ]}
        },  
        {
        "class": "آز سیستم‌های دیجیتال 2", 
        "maestro":"محمدرضا فتاح", 
        "type":"1", 
        "start":"16:00",
        "end":"17:30",
        "apartment":"ساختمان ازمایشگاه های برق", 
        "class_location":"",
            "students":{
            "base_url":"assets/avatars/",
            "count":"8", 
            "data": [
               {
                "avatar":"31.png"     
               },
               {
                "avatar":"32.png"     
               },
               {
                "avatar":"33.png"     
              },
              {
               "avatar":"34.png"     
              }
            ]}
        },
        {
    "class": "آز سیستم‌های کنترل خطی", 
    "maestro":"محمد دبستانی", 
    "type":"1", 
    "start":"18:00",
    "end":"19:30",
    "apartment":"ساختمان ازمایشگاه های برق", 
    "class_location":"",
        "students":{
        "base_url":"assets/avatars/",
        "count":"6", 
        "data": [
           {
            "avatar":"41.png"     
           },
           {
            "avatar":"42.png"     
           },
           {
            "avatar":"43.png"     
          },
          {
           "avatar":"44.png"     
          }
        ]}
        }
       ]
      },
      {
        "year":"1402",
        "month":"9",
        "day":"13",
        "classes":[
          {
                "class": "اتوماسیون صنعتی", 
                "maestro":"علیرضا فرجی", 
                "type":"1", 
                "start":"8:00",
                "end":"9:30",
                "apartment":"ساختمان ساتر", 
                "class_location":"کلاس 21",
                    "students":{
                    "base_url":"assets/avatars/",
                    "count":"10", 
                    "data": [
                       {
                        "avatar":"11.png"     
                       },
                       {
                        "avatar":"12.png"     
                       },
                       {
                        "avatar":"13.png"     
                      },
                      {
                       "avatar":"14.png"     
                      }
                    ]}
          },  
          {
            "color":"#03A9F4", 
                "class": "الکترونیک صنعتی", 
                "maestro":"محسن رحیمی", 
                "type":"1", 
                "start":"10:00",
                "end":"11:30",
                "apartment":"ساختمان ساتر", 
                "class_location":"کلاس 13",
                    "students":{
                    "base_url":"assets/avatars/",
                    "count":"10", 
                    "data": [
                       {
                        "avatar":"11.png"     
                       },
                       {
                        "avatar":"12.png"     
                       },
                       {
                        "avatar":"13.png"     
                      },
                      {
                       "avatar":"14.png"     
                      }
                    ]}
          },
          {
              "class": "مباحث ویژه", 
              "maestro":"مجید حاجتی پور", 
              "type":"1", 
              "start":"12:30",
              "end":"14:00",
              "apartment":"ساختمان اسلامی", 
              "class_location":"کلاس 128",
              "students":{
                  "base_url":"assets/avatars/",
                  "count":"23", 
                  "data": [
                     {
                      "avatar":"61.png"     
                     },
                     {
                      "avatar":"62.png"     
                     },
                     {
                      "avatar":"63.png"     
                     },
                     {
                      "avatar":"64.png"     
                     }
              ]}
          }, 
          {
            "class": "آمار و احتمالات مهندسی", 
            "maestro":"مهدی سلمان پور", 
            "type":"1", 
            "start":"14:00",
            "end":"15:30",
            "apartment":"ساختمان اسلامی", 
            "class_location":"کلاس 128",
            "students":{
                "base_url":"assets/avatars/",
                "count":"30", 
                "data": [
                   {
                    "avatar":"21.png"     
                   },
                   {
                    "avatar":"22.png"     
                   },
                   {
                    "avatar":"23.png"     
                  },
                  {
                   "avatar":"24.png"     
                  }
            ]}
          }
         ]
      },
      {
        "year":"1402",
        "month":"9",
        "day":"14",
        "classes":[
           {
                "class": "سیستم‌های کنترل مدرن", 
                "maestro":"سید حسین اجتهد", 
                "type":"1", 
                "start":"8:00",
                "end":"9:30",
                "apartment":"ساختمان ساتر", 
                "class_location":"کلاس 21",
                    "students":{
                    "base_url":"assets/avatars/",
                    "count":"24", 
                    "data": [
                       {
                        "avatar":"51.png"     
                       },
                       {
                        "avatar":"52.png"     
                       },
                       {
                        "avatar":"53.png"     
                      },
                      {
                       "avatar":"54.png"     
                      }
                    ]}
           },
           {
            "class": "از ماشین های الکتریکی 1", 
            "maestro":"پریسا سرافرازی", 
            "type":"1", 
            "start":"10:00",
            "end":"11:30",
            "apartment":"ساختمان ازمایشگاه های برق", 
            "class_location":"",
                "students":{
                "base_url":"assets/avatars/",
                "count":"8", 
                "data": [
                   {
                    "avatar":"31.png"     
                   },
                   {
                    "avatar":"32.png"     
                   },
                   {
                    "avatar":"33.png"     
                  },
                  {
                   "avatar":"34.png"     
                  }
                ]}
           },
           {
            "class": "اتوماسیون صنعتی", 
            "maestro":"علیرضا فرجی", 
            "type":"1", 
            "start":"12:30",
            "end":"14:00",
            "apartment":"ساختمان ساتر", 
            "class_location":"کلاس 21",
                "students":{
                "base_url":"assets/avatars/",
                "count":"10", 
                "data": [
                   {
                    "avatar":"11.png"     
                   },
                   {
                    "avatar":"12.png"     
                   },
                   {
                    "avatar":"13.png"     
                  },
                  {
                   "avatar":"14.png"     
                  }
                ]}
           },
           {
            "color":"#F44336",
            "class": "اصول سیستم‌های مخابراتی", 
            "maestro":"محسن حجازی", 
            "type":"1", 
            "start":"14:00",
            "end":"15:30",
            "apartment":"ساختمان ساتر", 
            "class_location":"کلاس22",
            "students":{
                "base_url":"assets/avatars/",
                "count":"30", 
                "data": [
                   {
                    "avatar":"21.png"     
                   },
                   {
                    "avatar":"22.png"     
                   },
                   {
                    "avatar":"23.png"     
                  },
                  {
                   "avatar":"24.png"     
                  }
                ]}
           },
           {
        "class": "تحلیل سیستم‌های انرژی الکتریکی 1", 
        "maestro":"علی کریمی", 
        "type":"1", 
        "start":"16:00",
        "end":"18:30",
        "apartment":"ساختمان ساتر", 
        "class_location":"کلاس16",
            "students":{
            "base_url":"assets/avatars/",
            "count":"6", 
            "data": [
               {
                "avatar":"41.png"     
               },
               {
                "avatar":"42.png"     
               },
               {
                "avatar":"43.png"     
              },
              {
               "avatar":"44.png"     
              }
            ]}
           }
         
         ]
      },
      {
        "year":"1402",
        "month":"9",
        "day":"16",
        "classes":[
           {
            "color":"#F44336",
            "class": "اصول سیستم‌های مخابراتی", 
            "maestro":"محسن حجازی", 
            "type":"کلاس جبرانی", 
            "start":"8:00",
            "end":"9:30",
            "apartment":"LMS دانشگاه", 
            "class_location":"کلاس مجازی",
            "students":{
                "base_url":"assets/avatars/",
                "count":"30", 
                "data": [
                   {
                    "avatar":"21.png"     
                   },
                   {
                    "avatar":"22.png"     
                   },
                   {
                    "avatar":"23.png"     
                  },
                  {
                   "avatar":"24.png"     
                  }
                ]}
           },
           {
            "color":"#F44336",
            "class": "اصول سیستم‌های مخابراتی", 
            "maestro":"محسن حجازی", 
            "type":"کلاس جبرانی", 
            "start":"9:30",
            "end":"11:00",
            "apartment":"LMS دانشگاه", 
            "class_location":"کلاس مجازی",
            "students":{
                "base_url":"assets/avatars/",
                "count":"30", 
                "data": [
                   {
                    "avatar":"21.png"     
                   },
                   {
                    "avatar":"22.png"     
                   },
                   {
                    "avatar":"23.png"     
                  },
                  {
                   "avatar":"24.png"     
                  }
                ]}
           }    
         ]
      },
      {
        "year":"1402",
        "month":"9",
        "day":"18",
        "classes":[
          {
               "color":"#03A9F4",
               "class": "الکترونیک صنعتی", 
               "maestro":"محسن رحیمی", 
               "type":"1", 
               "start":"10:00",
               "end":"11:30",
               "apartment":"ساختمان ساتر", 
               "class_location":"کلاس 13",
                   "students":{
                   "base_url":"assets/avatars/",
                   "count":"10", 
                   "data": [
                      {
                       "avatar":"11.png"     
                      },
                      {
                       "avatar":"12.png"     
                      },
                      {
                       "avatar":"13.png"     
                     },
                     {
                      "avatar":"14.png"     
                     }
                   ]}
          },
          {
              "class": "آمار و احتمالات مهندسی", 
              "maestro":"مهدی سلمان پور", 
              "type":"1", 
              "start":"14:00",
              "end":"15:30",
              "apartment":"ساختمان اسلامی", 
              "class_location":"کلاس 128",
              "students":{
                  "base_url":"assets/avatars/",
                  "count":"30", 
                  "data": [
                     {
                      "avatar":"21.png"     
                     },
                     {
                      "avatar":"22.png"     
                     },
                     {
                      "avatar":"23.png"     
                    },
                    {
                     "avatar":"24.png"     
                    }
              ]}
          },  
          {
          "class": "آز سیستم‌های دیجیتال 2", 
          "maestro":"محمدرضا فتاح", 
          "type":"1", 
          "start":"16:00",
          "end":"17:30",
          "apartment":"ساختمان ازمایشگاه های برق", 
          "class_location":"",
              "students":{
              "base_url":"assets/avatars/",
              "count":"8", 
              "data": [
                 {
                  "avatar":"31.png"     
                 },
                 {
                  "avatar":"32.png"     
                 },
                 {
                  "avatar":"33.png"     
                },
                {
                 "avatar":"34.png"     
                }
              ]}
          },
          {
      "class": "آز سیستم‌های کنترل خطی", 
      "maestro":"محمد دبستانی", 
      "type":"1", 
      "start":"18:00",
      "end":"19:30",
      "apartment":"ساختمان ازمایشگاه های برق", 
      "class_location":"",
          "students":{
          "base_url":"assets/avatars/",
          "count":"6", 
          "data": [
             {
              "avatar":"41.png"     
             },
             {
              "avatar":"42.png"     
             },
             {
              "avatar":"43.png"     
            },
            {
             "avatar":"44.png"     
            }
          ]}
          }
         ]
      },
      {
          "year":"1402",
          "month":"9",
          "day":"19",
          "classes":[
            {
                 "color":"#009688",
                 "class": "سیستم‌های کنترل مدرن", 
                 "maestro":"سید حسین اجتهد", 
                 "type":"1", 
                 "start":"8:00",
                 "end":"9:30",
                 "apartment":"ساختمان ساتر", 
                 "class_location":"کلاس 21",
                     "students":{
                     "base_url":"assets/avatars/",
                     "count":"24", 
                     "data": [
                        {
                         "avatar":"51.png"     
                        },
                        {
                         "avatar":"52.png"     
                        },
                        {
                         "avatar":"53.png"     
                       },
                       {
                        "avatar":"54.png"     
                       }
                     ]}
            },
            {   
                
                "class": "مباحث ویژه", 
                "maestro":"مجید حاجتی پور", 
                "type":"1", 
                "start":"12:30",
                "end":"14:00",
                "apartment":"ساختمان اسلامی", 
                "class_location":"کلاس 128",
                "students":{
                    "base_url":"assets/avatars/",
                    "count":"23", 
                    "data": [
                       {
                        "avatar":"61.png"     
                       },
                       {
                        "avatar":"62.png"     
                       },
                       {
                        "avatar":"63.png"     
                       },
                       {
                        "avatar":"64.png"     
                       }
                ]}
            },  
            {
            "color":"#F44336",
            "class": "اصول سیستم‌های مخابراتی", 
            "maestro":"محسن حجازی", 
            "type":"1", 
            "start":"14:00",
            "end":"15:30",
            "apartment":"ساختمان ساتر", 
            "class_location":"کلاس22",
            "students":{
                "base_url":"assets/avatars/",
                "count":"30", 
                "data": [
                   {
                    "avatar":"21.png"     
                   },
                   {
                    "avatar":"22.png"     
                   },
                   {
                    "avatar":"23.png"     
                  },
                  {
                   "avatar":"24.png"     
                  }
                ]}
            },
            {
        "class": "تحلیل سیستم‌های انرژی الکتریکی 1", 
        "maestro":"علی کریمی", 
        "type":"1", 
        "start":"16:00",
        "end":"18:30",
        "apartment":"ساختمان ساتر", 
        "class_location":"کلاس16",
            "students":{
            "base_url":"assets/avatars/",
            "count":"6", 
            "data": [
               {
                "avatar":"41.png"     
               },
               {
                "avatar":"42.png"     
               },
               {
                "avatar":"43.png"     
              },
              {
               "avatar":"44.png"     
              }
            ]}
            }
           ]
      },
      {
          "year":"1402",
          "month":"9",
          "day":"20",
          "classes":[
            {
                  "class": "اتوماسیون صنعتی", 
                  "maestro":"علیرضا فرجی", 
                  "type":"1", 
                  "start":"8:00",
                  "end":"10:30",
                  "apartment":"ساختمان ساتر", 
                  "class_location":"کلاس 21",
                      "students":{
                      "base_url":"assets/avatars/",
                      "count":"10", 
                      "data": [
                         {
                          "avatar":"11.png"     
                         },
                         {
                          "avatar":"12.png"     
                         },
                         {
                          "avatar":"13.png"     
                        },
                        {
                         "avatar":"14.png"     
                        }
                      ]}
            },  
            {
                  "class": "الکترونیک صنعتی", 
                  "maestro":"محسن رحیمی", 
                  "type":"1", 
                  "start":"10:00",
                  "end":"11:30",
                  "apartment":"ساختمان ساتر", 
                  "class_location":"کلاس 13",
                      "students":{
                      "base_url":"assets/avatars/",
                      "count":"10", 
                      "data": [
                         {
                          "avatar":"11.png"     
                         },
                         {
                          "avatar":"12.png"     
                         },
                         {
                          "avatar":"13.png"     
                        },
                        {
                         "avatar":"14.png"     
                        }
                      ]}
            },
            {
                "class": "مباحث ویژه", 
                "maestro":"مجید حاجتی پور", 
                "type":"1", 
                "start":"12:30",
                "end":"14:00",
                "apartment":"ساختمان اسلامی", 
                "class_location":"کلاس 128",
                "students":{
                    "base_url":"assets/avatars/",
                    "count":"23", 
                    "data": [
                       {
                        "avatar":"61.png"     
                       },
                       {
                        "avatar":"62.png"     
                       },
                       {
                        "avatar":"63.png"     
                       },
                       {
                        "avatar":"64.png"     
                       }
                ]}
            }, 
            {
              "class": "آمار و احتمالات مهندسی", 
              "maestro":"مهدی سلمان پور", 
              "type":"1", 
              "start":"14:00",
              "end":"15:30",
              "apartment":"ساختمان اسلامی", 
              "class_location":"کلاس 128",
              "students":{
                  "base_url":"assets/avatars/",
                  "count":"30", 
                  "data": [
                     {
                      "avatar":"21.png"     
                     },
                     {
                      "avatar":"22.png"     
                     },
                     {
                      "avatar":"23.png"     
                    },
                    {
                     "avatar":"24.png"     
                    }
              ]}
            }
           ]
      },
      {
          "year":"1402",
          "month":"9",
          "day":"21",
          "classes":[
             {
                  "color":"#009688",
                  "class": "سیستم‌های کنترل مدرن", 
                  "maestro":"سید حسین اجتهد", 
                  "type":"1", 
                  "start":"8:00",
                  "end":"9:30",
                  "apartment":"ساختمان ساتر", 
                  "class_location":"کلاس 21",
                      "students":{
                      "base_url":"assets/avatars/",
                      "count":"24", 
                      "data": [
                         {
                          "avatar":"51.png"     
                         },
                         {
                          "avatar":"52.png"     
                         },
                         {
                          "avatar":"53.png"     
                        },
                        {
                         "avatar":"54.png"     
                        }
                      ]}
             },
             {
              "class": "از ماشین های الکتریکی 1", 
              "maestro":"پریسا سرافرازی", 
              "type":"1", 
              "start":"10:00",
              "end":"11:30",
              "apartment":"ساختمان ازمایشگاه های برق", 
              "class_location":"",
                  "students":{
                  "base_url":"assets/avatars/",
                  "count":"8", 
                  "data": [
                     {
                      "avatar":"31.png"     
                     },
                     {
                      "avatar":"32.png"     
                     },
                     {
                      "avatar":"33.png"     
                    },
                    {
                     "avatar":"34.png"     
                    }
                  ]}
             },
             {
              "class": "اتوماسیون صنعتی", 
              "maestro":"علیرضا فرجی", 
              "type":"1", 
              "start":"12:30",
              "end":"14:00",
              "apartment":"ساختمان ساتر", 
              "class_location":"کلاس 21",
                  "students":{
                  "base_url":"assets/avatars/",
                  "count":"10", 
                  "data": [
                     {
                      "avatar":"11.png"     
                     },
                     {
                      "avatar":"12.png"     
                     },
                     {
                      "avatar":"13.png"     
                    },
                    {
                     "avatar":"14.png"     
                    }
                  ]}
             },
             {
              "color":"#F44336",
              "class": "اصول سیستم‌های مخابراتی", 
              "maestro":"محسن حجازی", 
              "type":"1", 
              "start":"14:00",
              "end":"15:30",
              "apartment":"ساختمان ساتر", 
              "class_location":"کلاس22",
              "students":{
                  "base_url":"assets/avatars/",
                  "count":"30", 
                  "data": [
                     {
                      "avatar":"21.png"     
                     },
                     {
                      "avatar":"22.png"     
                     },
                     {
                      "avatar":"23.png"     
                    },
                    {
                     "avatar":"24.png"     
                    }
                  ]}
             },
             {
          "class": "تحلیل سیستم‌های انرژی الکتریکی 1", 
          "maestro":"علی کریمی", 
          "type":"1", 
          "start":"16:00",
          "end":"18:30",
          "apartment":"ساختمان ساتر", 
          "class_location":"کلاس16",
              "students":{
              "base_url":"assets/avatars/",
              "count":"6", 
              "data": [
                 {
                  "avatar":"41.png"     
                 },
                 {
                  "avatar":"42.png"     
                 },
                 {
                  "avatar":"43.png"     
                },
                {
                 "avatar":"44.png"     
                }
              ]}
             }
           
           ]
      },
      {
        "year":"1402",
        "month":"9",
        "day":"25",
        "classes":[
          {
               "class": "الکترونیک صنعتی", 
               "maestro":"محسن رحیمی", 
               "type":"1", 
               "start":"10:00",
               "end":"11:30",
               "apartment":"ساختمان ساتر", 
               "class_location":"کلاس 13",
                   "students":{
                   "base_url":"assets/avatars/",
                   "count":"10", 
                   "data": [
                      {
                       "avatar":"11.png"     
                      },
                      {
                       "avatar":"12.png"     
                      },
                      {
                       "avatar":"13.png"     
                     },
                     {
                      "avatar":"14.png"     
                     }
                   ]}
          },
          {
              "class": "آمار و احتمالات مهندسی", 
              "maestro":"مهدی سلمان پور", 
              "type":"1", 
              "start":"14:00",
              "end":"15:30",
              "apartment":"ساختمان اسلامی", 
              "class_location":"کلاس 128",
              "students":{
                  "base_url":"assets/avatars/",
                  "count":"30", 
                  "data": [
                     {
                      "avatar":"21.png"     
                     },
                     {
                      "avatar":"22.png"     
                     },
                     {
                      "avatar":"23.png"     
                    },
                    {
                     "avatar":"24.png"     
                    }
              ]}
          },  
          {
          "class": "آز سیستم‌های دیجیتال 2", 
          "maestro":"محمدرضا فتاح", 
          "type":"1", 
          "start":"16:00",
          "end":"17:30",
          "apartment":"ساختمان ازمایشگاه های برق", 
          "class_location":"",
              "students":{
              "base_url":"assets/avatars/",
              "count":"8", 
              "data": [
                 {
                  "avatar":"31.png"     
                 },
                 {
                  "avatar":"32.png"     
                 },
                 {
                  "avatar":"33.png"     
                },
                {
                 "avatar":"34.png"     
                }
              ]}
          },
          {
      "class": "آز سیستم‌های کنترل خطی", 
      "maestro":"محمد دبستانی", 
      "type":"1", 
      "start":"18:00",
      "end":"19:30",
      "apartment":"ساختمان ازمایشگاه های برق", 
      "class_location":"",
          "students":{
          "base_url":"assets/avatars/",
          "count":"6", 
          "data": [
             {
              "avatar":"41.png"     
             },
             {
              "avatar":"42.png"     
             },
             {
              "avatar":"43.png"     
            },
            {
             "avatar":"44.png"     
            }
          ]}
          }
         ]
      },
      {
          "year":"1402",
          "month":"9",
          "is_holiday":true,
          "day":"26",
          "classes":[
            {
                 "color":"#009688",
                 "class": "سیستم‌های کنترل مدرن", 
                 "maestro":"سید حسین اجتهد", 
                 "type":"1", 
                 "start":"8:00",
                 "end":"9:30",
                 "apartment":"ساختمان ساتر", 
                 "class_location":"کلاس 21",
                     "students":{
                     "base_url":"assets/avatars/",
                     "count":"24", 
                     "data": [
                        {
                         "avatar":"51.png"     
                        },
                        {
                         "avatar":"52.png"     
                        },
                        {
                         "avatar":"53.png"     
                       },
                       {
                        "avatar":"54.png"     
                       }
                     ]}
            },
            {
                "color":"#FF6666",
                "class": "مباحث ویژه", 
                "maestro":"مجید حاجتی پور", 
                "type":"1", 
                "start":"12:30",
                "end":"14:00",
                "apartment":"ساختمان اسلامی", 
                "class_location":"کلاس 128",
                "students":{
                    "base_url":"assets/avatars/",
                    "count":"23", 
                    "data": [
                       {
                        "avatar":"61.png"     
                       },
                       {
                        "avatar":"62.png"     
                       },
                       {
                        "avatar":"63.png"     
                       },
                       {
                        "avatar":"64.png"     
                       }
                ]}
            },  
            {
            "color":"#F44336",
            "class": "اصول سیستم‌های مخابراتی", 
            "maestro":"محسن حجازی", 
            "type":"1", 
            "start":"14:00",
            "end":"15:30",
            "apartment":"ساختمان ساتر", 
            "class_location":"کلاس22",
            "students":{
                "base_url":"assets/avatars/",
                "count":"30", 
                "data": [
                   {
                    "avatar":"21.png"     
                   },
                   {
                    "avatar":"22.png"     
                   },
                   {
                    "avatar":"23.png"     
                  },
                  {
                   "avatar":"24.png"     
                  }
                ]}
            },
            {
              "color":"#607D8B",    
        "class": "تحلیل سیستم‌های انرژی الکتریکی 1", 
        "maestro":"علی کریمی", 
        "type":"1", 
        "start":"16:00",
        "end":"18:30",
        "apartment":"ساختمان ساتر", 
        "class_location":"کلاس16",
            "students":{
            "base_url":"assets/avatars/",
            "count":"6", 
            "data": [
               {
                "avatar":"41.png"     
               },
               {
                "avatar":"42.png"     
               },
               {
                "avatar":"43.png"     
              },
              {
               "avatar":"44.png"     
              }
            ]}
            }
           ]
      },
      {
          "year":"1402",
          "month":"9",
          "day":"27",
          "classes":[
            {
                  "color":"#FFEB3B",
                  "class": "اتوماسیون صنعتی", 
                  "maestro":"علیرضا فرجی", 
                  "type":"1", 
                  "start":"8:00",
                  "end":"10:30",
                  "apartment":"ساختمان ساتر", 
                  "class_location":"کلاس 21",
                      "students":{
                      "base_url":"assets/avatars/",
                      "count":"10", 
                      "data": [
                         {
                          "avatar":"11.png"     
                         },
                         {
                          "avatar":"12.png"     
                         },
                         {
                          "avatar":"13.png"     
                        },
                        {
                         "avatar":"14.png"     
                        }
                      ]}
            },  
            {
                  "color":"#03A9F4",
                  "class": "الکترونیک صنعتی", 
                  "maestro":"محسن رحیمی", 
                  "type":"1", 
                  "start":"10:00",
                  "end":"11:30",
                  "apartment":"ساختمان ساتر", 
                  "class_location":"کلاس 13",
                      "students":{
                      "base_url":"assets/avatars/",
                      "count":"10", 
                      "data": [
                         {
                          "avatar":"11.png"     
                         },
                         {
                          "avatar":"12.png"     
                         },
                         {
                          "avatar":"13.png"     
                        },
                        {
                         "avatar":"14.png"     
                        }
                      ]}
            },
            {
                "color":"#FF6666",
                "class": "مباحث ویژه", 
                "maestro":"مجید حاجتی پور", 
                "type":"1", 
                "start":"12:30",
                "end":"14:00",
                "apartment":"ساختمان اسلامی", 
                "class_location":"کلاس 128",
                "students":{
                    "base_url":"assets/avatars/",
                    "count":"23", 
                    "data": [
                       {
                        "avatar":"61.png"     
                       },
                       {
                        "avatar":"62.png"     
                       },
                       {
                        "avatar":"63.png"     
                       },
                       {
                        "avatar":"64.png"     
                       }
                ]}
            }, 
            {
              "color":"#673AB7",
              "class": "آمار و احتمالات مهندسی", 
              "maestro":"مهدی سلمان پور", 
              "type":"1", 
              "start":"14:00",
              "end":"15:30",
              "apartment":"ساختمان اسلامی", 
              "class_location":"کلاس 128",
              "students":{
                  "base_url":"assets/avatars/",
                  "count":"30", 
                  "data": [
                     {
                      "avatar":"21.png"     
                     },
                     {
                      "avatar":"22.png"     
                     },
                     {
                      "avatar":"23.png"     
                    },
                    {
                     "avatar":"24.png"     
                    }
              ]}
            }
           ]
      },
      {
          "year":"1402",
          "month":"9",
          "day":"28",
          "classes":[
             {
                  "color":"#009688",
                  "class": "سیستم‌های کنترل مدرن", 
                  "maestro":"سید حسین اجتهد", 
                  "type":"1", 
                  "start":"8:00",
                  "end":"9:30",
                  "apartment":"ساختمان ساتر", 
                  "class_location":"کلاس 21",
                      "students":{
                      "base_url":"assets/avatars/",
                      "count":"24", 
                      "data": [
                         {
                          "avatar":"51.png"     
                         },
                         {
                          "avatar":"52.png"     
                         },
                         {
                          "avatar":"53.png"     
                        },
                        {
                         "avatar":"54.png"     
                        }
                      ]}
             },
             {
              "color":"#8BC34A",
              "class": "از ماشین های الکتریکی 1", 
              "maestro":"پریسا سرافرازی", 
              "type":"1", 
              "start":"10:00",
              "end":"11:30",
              "apartment":"ساختمان ازمایشگاه های برق", 
              "class_location":"",
                  "students":{
                  "base_url":"assets/avatars/",
                  "count":"8", 
                  "data": [
                     {
                      "avatar":"31.png"     
                     },
                     {
                      "avatar":"32.png"     
                     },
                     {
                      "avatar":"33.png"     
                    },
                    {
                     "avatar":"34.png"     
                    }
                  ]}
             },
             {
              "color":"#FFEB3B",
              "class": "اتوماسیون صنعتی", 
              "maestro":"علیرضا فرجی", 
              "type":"1", 
              "start":"12:30",
              "end":"14:00",
              "apartment":"ساختمان ساتر", 
              "class_location":"کلاس 21",
                  "students":{
                  "base_url":"assets/avatars/",
                  "count":"10", 
                  "data": [
                     {
                      "avatar":"11.png"     
                     },
                     {
                      "avatar":"12.png"     
                     },
                     {
                      "avatar":"13.png"     
                    },
                    {
                     "avatar":"14.png"     
                    }
                  ]}
             },
             {
              "color":"#F44336",
              "class": "اصول سیستم‌های مخابراتی", 
              "maestro":"محسن حجازی", 
              "type":"1", 
              "start":"14:00",
              "end":"15:30",
              "apartment":"ساختمان ساتر", 
              "class_location":"کلاس22",
              "students":{
                  "base_url":"assets/avatars/",
                  "count":"30", 
                  "data": [
                     {
                      "avatar":"21.png"     
                     },
                     {
                      "avatar":"22.png"     
                     },
                     {
                      "avatar":"23.png"     
                    },
                    {
                     "avatar":"24.png"     
                    }
                  ]}
             },
             {
              "color":"#607D8B",
          "class": "تحلیل سیستم‌های انرژی الکتریکی 1", 
          "maestro":"علی کریمی", 
          "type":"1", 
          "start":"16:00",
          "end":"18:30",
          "apartment":"ساختمان ساتر", 
          "class_location":"کلاس16",
              "students":{
              "base_url":"assets/avatars/",
              "count":"6", 
              "data": [
                 {
                  "avatar":"41.png"     
                 },
                 {
                  "avatar":"42.png"     
                 },
                 {
                  "avatar":"43.png"     
                },
                {
                 "avatar":"44.png"     
                }
              ]}
             }
           
           ]
      }
    ] 
  }
  
  
  
  