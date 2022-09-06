//
//  CategoryViewController.m
//  viptemp
//
//  Created by hello on 2022/8/31.
//

#import "CategoryViewController.h"
#import "CategoryViewController+Add.h"
#import "MyObject.h"

typedef struct {
    NSString *name;
} MyStruct;

@interface CategoryViewController ()
// ⚠️注意属性修饰词：unsafe_unretained
@property (nonatomic, unsafe_unretained) MyObject *object;
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"野指针与僵尸对象定位";
    
    // 手动制造野指针
    // 当点击页面时，访问野指针
//    MyObject *obj = [MyObject new];
//    self.object = obj;
//    self.object.name = @"Hello";
//    void *p = (__bridge void *)(self.object);
//
//    NSLog(@"%p--%@", self.object, self.object.name);
//    NSLog(@"%p--%@", p, [((__bridge MyObject *)p) name]);
    
    
    // C指针
//    MyStruct *ms;
//    ms = malloc(sizeof(MyStruct));
//    // 此时内存中的数据不可控 可能是之前未擦除的
//    printf("%x\n", *((int *)ms));
//    // 使用可能会出现野指针问题
//    NSLog(@"%@", ms->name);
//    // 进行内存数据的初始化
//    ms->name = @"HelloWorld";
//    // 回收内存
//    free(ms);
//    // 此时内存中的数据不可控
//    NSLog(@"%@", ms->name);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%p",self->_object);
    NSLog(@"%@",self.object);       // Thread 1: EXC_BAD_ACCESS (code=1, address=0x237772a80)
    NSLog(@"%@",self.object.name);  // Thread 1: EXC_BAD_ACCESS (code=1, address=0x237772a80)
    
    // 分类添加属性
//    NSInteger random = arc4random_uniform(1000000);
//    self.count = random;
//    self.code = @(random + 1);
//    self.identifier = @(random + 2).stringValue;
//    NSLog(@"\ncount=%ld \ncode=%@ \nidentifier=%@", self.count, self.code, self.identifier);
}

@end
