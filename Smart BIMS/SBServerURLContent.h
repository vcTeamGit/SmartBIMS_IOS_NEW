/**
 * 프로젝트 내 URL을 개발 및 검수 용으로
 * 호출할 수 있도록 대응 (Objective C 에서 호출하는 URL)
 *
 * @author HMWOO
 * @version 1.0
 */

#define DEV 0
#define PROD 1

// 개발 DB 접근 시 TARGET을 DEV로 설정
// 상용 DB 접근 시 TARGET을 PROD로 설정
// DEV : 개발, PROD : 상용
#define TARGET PROD

// 로그인 처리 URL => [ SBLoginViewController.m ]
#define URL_IDPW_LOGIN [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBLoginProc.jsp"]

// 공지사항 정보 => [ MainViewController.m, SBBoardViewController.m, SBBoardContentViewController.m ]
#define URL_NOTICE_INFO [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBNoticeWithConfirmInfoDAO.jsp"]

// 확인 안된 공지사항 갯수 확인 => [ MainViewController.m ]
#define URL_NOT_CONFIRM_NOTICE_CNT [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBBoardDAO.jsp"]

// 인계 정보 조회 => [ SBTakeOverInfoViewController.m ]
#define URL_QUERY_TAKEOVER_INFO [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBTakeOverBloodDAONew.jsp"]

// 수거자 인증, 수거자 등록 전 인계 정보 조회, 인계 정보 저장 => [ MainViewController.m | SBTakeOverViewController.m | SBTakeOverActionViewController.m ]
// 수행 시 INSERT, UPDATE 처리 수행되므로 주의
#define URL_MANAGE_TAKEOVER_INFO [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBTakeOverBloodDAONew_TEST1.jsp"]

// 채혈전 확인사항 or 2차 일치검사 → 헌혈자 바코드 조회 => [ SBBloodinfoViewController.m | SBSecondMatchingViewController.m | SB2ndMatchingFrom1stViewController ]
#define URL_INQUIRE_USER_BARCODE [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBMatchingBloodInfoDAO.jsp"]

// 채혈전 확인사항 → 1차 일치 검사 버튼 클릭 (혈액제제코드, 혈액백코드 일치 조회 후 혈액팩 바코드 조회) => [ SBBloodinfoViewController.m | SBSecondMatchingViewController.m ]
#define URL_GET_BLOOD_PACK_NO [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBCheckBldProcAndBagCode.jsp"]

// 채혈전 확인사항 → 1차 일치 검사 → 헌혈자 바코드 조회(1차 일치 검사가 완료되었는지 확인) => [ SBFirstMatchingViewController.m ]
#define URL_CHECK_FIRST_MATCHING_COMPLETE [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBMatchingCommonDAOTest.jsp"]

// 채혈전 확인사항 → 1차 일치 검사 → 확인  => [ SBFirstMatchingViewController.m ]
// 수행 시 INSERT, UPDATE 처리 수행되므로 주의
#define URL_FIRST_MATCHING_TEST [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBMatchingFirstStepWithUdiTR.jsp"]

// 채혈전 확인사항(다종성분) → 확인 → 확인(다종성분 1차 일치검사 UDI 기기 추가)
// 신규 추가 항목(다종 성분 대응으로 만들었지만 기존 URL_FIRST_MATCHING_TEST 내 로직이 LOT넘버 길이별 자르는 기능이 포함되어 있지 않아
// 해당 내역 추가하여 일반 성분도 대응하도록 작성
#define URL_MULTI_FIRST_MATCHING_TEST [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBMultiMatchingFirstStepWithUdiTR.jsp"]

// 2차 일치 검사 → 헌혈자 바코드 조회 시 1차, 2차, BSD여부, 채혈종료시간입력 여부 확인 => [ SBSecondMatchingViewController.m | SB2ndMatchingFrom1stViewController | SBBloodEndTimeViewController.m | SBMultiSecondMatchingViewController ]
#define URL_CHECK_MATCHING_COMPLETE [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBMatchingCommonDAO.jsp"]

// 2차 일치 검사 => [ SBSecondMatchingViewController.m ]
// 수행 시 INSERT, DELETE, UPDATE 처리 수행되므로 주의
#define URL_SECOND_MATCHING_TEST [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBMatchingSecondStepWithEhTR.jsp"]

// 2차 일치 검사 → 채혈장비 정보 취득 => [ SBSecondMatchingViewController.m ]
#define URL_GET_BLD_ASSET_INFO [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBAssetNoInfoWithBldChkDAO.jsp"]

// 채혈 종료시간 입력 → 저장 => [ SBBloodEndTimeViewController.m ]
// 수행 시 INSERT 처리 수행되므로 주의
#define URL_SAVE_END_TIME [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBBloodEndTimeTR.jsp"]

// 메인 화면 → 혈액 인계 화면 호출 => [ SBTakeOverViewController.m ]
#define URL_GET_TAKEOVER_BLOOD_CNT [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/Swift_SBTakeOverBloodRegister.jsp"]

// 혈액 인계 화면 → 임시저장 or 임시저장 불러오기 => [ SBTakeOverViewController.m ]
#define URL_MANAGE_TEMP_TAKEOVER_INFO [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBTakeOverBloodTemporarySave.jsp"]

// 혈액 인계 화면 → 다음 버튼 클릭시 로그 작성
#define URL_SAVE_LOG_INFO [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBLogSave.jsp"]

// 파일 업로드
#define URL_FILE_UPLOAD [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBFileUploadTest.jsp"]

// 채혈내역조회화면 → [ SBBloodGatheringListViewController.m ]
#define URL_SEARCH_BLOOD_COLLECTION [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBBloodGatheringInfoDAO_New_TEST1.jsp"]

// 디바이스인증화면 → [ SBDeviceConfirmViewController.m ]
#define URL_DEVICE_CONFIRM [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBDeviceConfirmService.jsp"]

// 채혈내역통계화면 → [ SBEtcSrchStaViewController.m ]
#define URL_STAT_BLOOD_COLLECTION [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBNurEtcSearchStaDAO.jsp"]

// 특이사항화면, 헌혈적격여부조회화면 → [ SBSpecialDetailViewController.m | SBSideEffectCheckViewController.m | SBPreUnfitnessDetailViewController.m | SBFitnessCheckViewController.m ]
#define URL_SPECIAL_DETAIL [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBDonorFitnessCheckDetailCommonDAO.jsp"]

// 헌혈관련증상화면 → [ SBSideEffectsListViewController.m ]
#define URL_SYMPTOM_BLOOD_INFO [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBSideEffectsInfoDAO.jsp"]

// 운영반편성정보화면 → [ SBMgrInfoViewController.m ]
#define URL_OPERATE_INFO [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBMgrInfoDAO.jsp"]

// 헌혈적격여부조회화면 → [ SBFitnessCheckViewController.m ]
#define URL_SEARCH_SPECIAL_LOG [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBCommonViewLogTR.jsp"]

// 헌혈적격여부조회화면 체크 → [ SBFitnessCheckViewController.m ]
#define URL_CHECK_SPECIAL [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBDonorFitnessCheckDAO.jsp"]

// 성분채혈결과입력화면 → [ SBPcResultViewController.m ]
#define URL_PCR_RESULT [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBPcResultBloodInfoDAO.jsp"]

// 성분채혈결과입력화면 → [ SBPcResultViewController.m ]
#define URL_SAVE_PCR_INFO [NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBPcResultSaveTR.jsp"]

@interface SBServerURLContent : NSObject

extern NSString *BLOOD_SERVER;

extern NSString *SERVER_TARGET;

// 인계 혈액 등록화면에서 혈액등록, 등록혈액삭제 등을 관리하는 URL => [ BloodRegisterURLInfo.swift ]
// 수행 시 INSERT, DELETE 처리 수행되므로 주의
extern NSString *URL_MANAGE_TAKEOVER_BLOOD;

// 혈액 인계 정보 조회 화면에서 인계 혈액 정보를 취득하는 URL => [ BloodRegisterURLInfo.swift ]
extern NSString *URL_GET_TAKEOVER_BLOOD_INFO;

@end
