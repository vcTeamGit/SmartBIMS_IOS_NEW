
// 로그인 처리 URL => [ SBLoginViewController.m ]
#define URL_IDPW_LOGIN [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBLoginProc.jsp"]

// 모든 공지사항 갯수 확인 => [ MainViewController.m ]
#define URL_NOTICE_CNT [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBNoticeWithConfirmInfoDAO.jsp"]

// 확인 안된 공지사항 갯수 확인 => [ MainViewController.m ]
#define URL_NOT_CONFIRM_NOTICE_CNT [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBBoardDAO.jsp"]

// 수거자 인증 => [ MainViewController.m ]
#define URL_COLLECTOR_AUTH [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBTakeOverBloodDAONew_TEST1.jsp"]

// 채혈전 확인사항 or 2차 일치검사 → 헌혈자 바코드 조회 => [ SBBloodinfoViewController.m | SBSecondMatchingViewController.m | SB2ndMatchingFrom1stViewController ]
#define URL_INQUIRE_USER_BARCODE [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBMatchingBloodInfoDAO.jsp"]

// 채혈전 확인사항 → 1차 일치 검사 버튼 클릭 (혈액제제코드, 혈액백코드 일치 조회 후 혈액팩 바코드 조회) => [ SBBloodinfoViewController.m | SBSecondMatchingViewController.m ]
#define URL_GET_BLOOD_PACK_NO [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBCheckBldProcAndBagCode.jsp"]

// 채혈전 확인사항 → 1차 일치 검사 → 헌혈자 바코드 조회(1차 일치 검사가 완료되었는지 확인) => [ SBFirstMatchingViewController.m ]
#define URL_CHECK_FIRST_MATCHING_COMPLETE [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBMatchingCommonDAOTest.jsp"]

// 채혈전 확인사항 → 1차 일치 검사 → 확인  => [ SBFirstMatchingViewController.m ]
// 수행 시 INSERT, UPDATE 처리 수행되므로 주의
#define URL_FIRST_MATCHING_TEST [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBMatchingFirstStepWithUdiTR.jsp"]

// 2차 일치 검사 → 헌혈자 바코드 조회 시 1차, 2차, BSD여부, 채혈종료시간입력 여부 확인 => [ SBSecondMatchingViewController.m | SB2ndMatchingFrom1stViewController | SBBloodEndTimeViewController.m ]
#define URL_CHECK_MATCHING_COMPLETE [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBMatchingCommonDAO.jsp"]

// 2차 일치 검사 => [ SBSecondMatchingViewController.m ]
// 수행 시 INSERT, DELETE, UPDATE 처리 수행되므로 주의
#define URL_SECOND_MATCHING_TEST [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBMatchingSecondStepWithEhTR.jsp"]

// 2차 일치 검사 → 채혈장비 정보 취득 => [ SBSecondMatchingViewController.m ]
#define URL_GET_BLD_ASSET_INFO [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBAssetNoInfoWithBldChkDAO.jsp"]

// 채혈 종료시간 입력 → 저장 => [ SBBloodEndTimeViewController.m ]
#define URL_SAVE_END_TIME [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBBloodEndTimeTR.jsp"]

@interface SBServerURLContent : NSObject

extern NSString *BLOOD_SERVER;

extern NSString *SERVER_TARGET;

// 인계 혈액 등록화면에서 혈액등록, 등록혈액삭제 등을 관리하는 URL
extern NSString *URL_MANAGE_TAKEOVER_BLOOD;

// 혈액 인계 정보 조회 화면에서 인계 혈액 정보를 취득하는 URL
extern NSString *URL_GET_TAKEOVER_BLOOD_INFO;

@end
