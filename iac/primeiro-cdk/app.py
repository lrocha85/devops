#!/usr/bin/env python3

import aws_cdk as cdk

from primeiro_cdk.primeiro_cdk_stack import PrimeiroCdkStack


app = cdk.App()
PrimeiroCdkStack(app, "primeiro-cdk")

app.synth()
