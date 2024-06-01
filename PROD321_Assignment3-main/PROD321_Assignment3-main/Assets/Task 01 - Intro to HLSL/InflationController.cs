/* In Task 1, you will be modifying a vertex/fragment
 * shader to learn about Shader programming, including how
 * to create variables, use Semantic tagging, swizzle packed 
 * array variables, use properties, and set uniform shader
 * variables values from C# code
 *
 * This class is used to control a uniform shader variable 
 * in our shader. The places we have to put code is highlighted
 * in comments
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2021, University of Canterbury
 * Written by Adrian Clark
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// The name of our script
public class InflationController : MonoBehaviour
{
    // Public variables to assign the minimum shader variable value,
    // the maximum shader variable value, and the time between cycles
    public float minimumShaderVariableValue;
    public float maximumShaderVariableValue;
    public float TimeToCycle;

    // Update is called once per frame
    void Update()
    {
        // Use a sine wave to calculate a value between 0 and 1 based on the
        // current time and the to complete a cycle
        float shaderValue = (Mathf.Sin((Time.realtimeSinceStartup * Mathf.PI) / TimeToCycle) + 1) / 2;

        // Scale that value to be between minimumShaderVariableValue and
        // maximumShaderVariableValue
        shaderValue = shaderValue * (maximumShaderVariableValue - minimumShaderVariableValue) + minimumShaderVariableValue;

        /*******
         * TODO: SubTask 5 code goes here
         *******/
        GetComponent<MeshRenderer>().material.SetFloat("inflationValue", shaderValue);
    }
}
