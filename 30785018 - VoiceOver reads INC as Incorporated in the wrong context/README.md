# VoiceOver reads INC as Incorporated in the wrong context.

[rdar://30785018](rdar://30785018)

### Description
VoiceOver reads all INC as Incorporated, even when it's followed by Number.

For example: INC000234, it reads as 'Incorporated 0-0-0-0-2-3-4' , instead, it should read 'I-N-C-0-0-0-0-2-3-4'

### Steps to Reproduce
- Turn on Accessibility/VoiceOver.
- Run the sample project.
- Notice how VoiceOver read the label.

### Expected Results
I would expect VoiceOver to spell out INC, not reading it as 'Incorporated' in this case.

### Actual Results
'INC000234' is read as 'Incorporated 0-0-0-0-2-3-4'. 

### Additional Notes
This seems to be a problem on iOS only. On MacOs, it spells out correctly.

My current workaround is to set accessiblityLabel to 'I.N.C.0000234'.

### Version
iOS 9+, Xcode 8.2.1 (8C1002)
