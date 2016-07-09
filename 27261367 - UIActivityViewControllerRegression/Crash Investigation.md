[UIActivityViewController setModalPresentationStyle:] on iOS 9.3

if ( (unsigned __int64)(a3 - 1) > 1 ) -> ok
else 
      (struct UIScrollView *)CFSTR("UIActivityViewController does not support a modal presentation style of UIModalPresentationFormSheet or UIModalPresentationPageSheet."),



iOS 10

same but in the setter

    if ( (unsigned __int8)_UIAppUseModernRotationAndPresentationBehaviors() )
    {
      if ( !(unsigned __int8)((__int64 (__fastcall *)(struct UIActivityViewController *, _QWORD))objc_msgSend_ptr)(
                               self,
                               selRef_allowsEmbedding) )
        v3 = 100LL;
    }
    v4 = self;
    v5 = classRef_UIActivityViewController_0;
    objc_msgSendSuper2(&v4, selRef_setModalPresentationStyle_, v3, self, classRef_UIActivityViewController_0);



bool __cdecl -[UIActivityViewController allowsEmbedding](struct UIActivityViewController *self, SEL a2)
{
  return self->_shouldMatchOnlyUserElectedExtensions;
}



//(call is not new)
_UIAppUseModernRotationAndPresentationBehaviors() -> [UIWindow _transformLayerRotationsAreEnabled] ->_UIApplicationLinkedOnVersion > 0x7FFFF;




// iOS 9
bool __cdecl -[UIActivityViewController _requiresCustomPresentationController](struct UIActivityViewController *self, SEL a2)
{
  return (unsigned __int64)((__int64 (__fastcall *)(struct UIActivityViewController *, char *))objc_msgSend_ptr)(
                             self,
                             selRef_allowsEmbedding) ^ 1;
}