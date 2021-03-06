
ENABLE_TESTING(true)

QT5_ADD_RESOURCES(test_RESOURCE_SOURCES
    ${bibletime_SOURCE_DIR}/src/mobile/btm.qrc
    ${bibletime_SOURCE_DIR}/i18n/messages/test_translate.qrc
)

SET(test_OTHER_SOURCES
    ${bibletime_SOURCE_DIR}/src/frontend/messagedialog.cpp
)

FUNCTION(test_a_class testDir testClass )
    PROJECT(test_${testClass})
    ADD_EXECUTABLE(test_${testClass}
        ${testDir}/test_${testClass}.cpp
        ${test_OTHER_SOURCES}
        ${test_RESOURCE_SOURCES}
    )
    SET_TARGET_PROPERTIES("test_${testClass}" PROPERTIES COMPILE_FLAGS ${Sword_CFLAGS_OTHER} -std=c++11 )
    QT5_USE_MODULES(test_${testClass} Widgets Xml Network Test)
    TARGET_LINK_LIBRARIES(test_${testClass}
        bibletime_common
        ${Sword_LDFLAGS}
        ${CLucene_LIBRARY}
    )
    ADD_TEST(NAME ${testClass} COMMAND test_${testClass})
ENDFUNCTION(test_a_class)

# The first 2 tests install modules that the other tests need
# They should be ran in this order
test_a_class(tests/backend/btsourcesthread btsourcesthread)
test_a_class(tests/backend/btinstallthread btinstallthread)

test_a_class(tests/backend/managers/cswordbackend cswordbackend)
test_a_class(tests/backend/keys/cswordversekey cswordversekey)
test_a_class(tests/backend/models/btlistmodel btlistmodel)
