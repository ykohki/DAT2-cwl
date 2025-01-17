#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
doc: A fast and sensitive gapped read aligner
requirements:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/bowtie2:2.3.5--py36he860b03_0
  InlineJavascriptRequirement: {}
baseCommand: bowtie2
arguments:
  - prefix: -S
    position: 3
    valueFrom: $(inputs.fastq.basename.replace('.gz', '').replace('.fastq', '').replace('.fq', '')).sam
inputs:
  genome_index:
    type: File
    inputBinding:
      prefix: -x
      position: 0
      valueFrom: $(inputs.genome_index.dirname)/$(inputs.genome_index.nameroot)
    secondaryFiles:
      - ^.1.bt2
      - ^.2.bt2
      - ^.3.bt2
      - ^.4.bt2
      - ^.rev.1.bt2
      - ^.rev.2.bt2
  fastq:
    type: File
    inputBinding:
      prefix: -U
      position: 1
  num_process:
    type: int
    default: 4
    inputBinding:
      prefix: -p
      position: 2
outputs:
  sam:
    type: File
    outputBinding:
      glob: $(inputs.fastq.basename.replace('.gz', '').replace('.fastq', '').replace('.fq', '')).sam
  stdout: stdout
  stderr: stderr
stdout: bowtie2-pe-stdout.log
stderr: bowtie2-pe-stderr.log
