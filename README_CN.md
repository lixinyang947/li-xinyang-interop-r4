# 李欣阳 FHIR 原生互操作与数据质量框架 — FHIR R4 技术制品包

**版本：** 0.1.0  
**日期：** 2026-07-21  
**FHIR：** R4 / 4.0.1  
**状态：** Draft / Experimental  
**方法论作者：** Xinyang Li（李欣阳）

本项目把两份“方法论叙述”转化为可由 FHIR 工具链读取的技术制品。它用于证明方法论已经被形式化为 profiles、映射规则、术语制品、验证契约和可追踪示例；它不是生产部署证明，也不宣称已经在医院、HIE 或 HITC 平台完成上线。

## 主要制品

- **35 个 FHIR R4 Profiles**：Patient、Encounter、Observation、Condition、MedicationRequest、DiagnosticReport、Procedure、Immunization、AllergyIntolerance、DocumentReference、Provenance 等。
- **55 个 StructureDefinition**：35 个资源 Profile、11 个扩展、9 个 HL7 v2/C-CDA 输入逻辑模型；均含 SUSHI 生成的 snapshot。
- **11 个 ConceptMap**：6 个可直接审阅的代表性 HL7 v2→FHIR 映射，以及 5 个受许可或机构治理约束的空模板。
- **12 个 StructureMap**：HL7 v2 PID/PV1/OBX/OBR/ORC/SCH/TXA 与 C-CDA Problem/Allergy/Procedure/Medication/Discharge Medication 的结构转换；同时提供 JSON 和可读 `.map` 源文件。
- **ImplementationGuide、CapabilityStatement、2 个 OperationDefinition、2 个 SearchParameter**。
- **7 个 CodeSystem 与 7 个 ValueSet**：覆盖 FFR、CSC、RIR、TC、MSR、TCR 六项质量指标，以及映射策略、验证阶段、来源格式和转换活动。
- **17 个独立合成示例 + 1 个规范交换 Bundle**：演示质量指标 Observation、资源级 Provenance、映射置信度与 Merkle root 元数据。
- **追踪矩阵、制品清单、验证报告和 FHIR NPM `.tgz` 包**。

## 目录说明

```text
input/fsh/                 FSH 源文件：profiles、extensions、terminology、examples
input/resources/           手工编写的 ConceptMap、StructureMap、CapabilityStatement 等
input/maps/                可读 FHIR Mapping Language（FML）源文件
input/pagecontent/         IG Publisher 页面内容
fsh-generated/resources/   SUSHI 生成并组装后的全部 FHIR JSON
source_documents/          两份方法论源文件及 SHA-256 哈希
scripts/                   构建、组装、完整性检查和离线验证脚本
dist/                      FHIR NPM package 与 `.tgz` 分发包
```

## 构建与验证

```bash
npm ci
npm run build
```

完整构建依次执行：

1. SUSHI 3.20.0 编译 FSH，并为全部 StructureDefinition 生成 snapshot；
2. 将手工制品与生成制品组装到 ImplementationGuide；
3. 生成 FHIR NPM package、清单和哈希；
4. 运行确定性完整性检查；
5. 使用离线 R4 验证器检查全部非 StructureDefinition JSON。

单独执行：

```bash
npm run build:fsh
npm run assemble
npm run check
npm run validate:offline
```

## 重要边界

1. Canonical 目前为 `https://example.org/fhir/li-xinyang-interop-r4`，发布前必须替换为真实、长期稳定的域名。
2. NDC→RxNorm、ICD-9-CM→ICD-10-CM、local→LOINC/SNOMED CT/RxNorm 的 ConceptMap 是治理模板，未填入可能受许可、版本或机构政策约束的映射内容。
3. C-CDA StructureMap 的输入是经过 XPath/模板识别后形成的规范化逻辑条目；原始 XML 解析属于接入适配层。
4. TF-IDF 模糊匹配、FHIR `$validate-code`、Merkle 树存储、联邦查询规划和缓存属于方法与接口契约，本包不把它们伪装成已经运行的服务。
5. 示例数据和性能数字仅用于技术演示或目标表达，不得作为真实患者数据、生产结果或临床效果证明。

更完整的边界说明见 `METHODOLOGY_ASSUMPTIONS.md` 和 `input/pagecontent/limitations.md`。
